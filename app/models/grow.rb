# frozen_string_literal: true

class Grow < ApplicationRecord
  include BirthTypeEnum

  attr_accessor :strain_id

  default_scope { order(start_date: :desc) }

  enum grow_status: {
    scheduled: 0,
    seedling: 1,
    vegging: 2,
    flowering: 3,
    flushing: 4,
    drying: 5,
    curing: 6,
    done: 7,
    aborted: 8
  }

  enum substrate: { soil: 0, coco: 1, hydro: 2, aero: 3 }

  enum flowering: { photoperiodic: 0, autoflowering: 1 }

  has_many :subjects, dependent: :delete_all
  has_many :weeks, dependent: :delete_all
  has_many :observations, dependent: :delete_all
  has_many :events, as: :eventable, dependent: :destroy
  has_one :harvest

  validates :description, presence: true
  validates :grow_status, presence: true
  validate :validate_number_of_subjects
  validate :validate_birth_type_and_mother

  def validate_number_of_subjects
    return unless birth_type == 'from_clone' && mother_id.present?
    return unless number_of_subjects.blank?

    errors.add(:number_of_subjects, "can't be blank when birth type is 'from clone' and mother is selected.")
  end

  def validate_birth_type_and_mother
    return unless birth_type == 'from_clone' && mother_id.blank?

    errors.add(:mother_id, "must be selected when birth type is 'from clone'.")
  end

  def name
    "##{id} - #{description}"
  end

  def harvestable?
    drying? or curing? or done?
  end

  def active_subjects
    subjects.joins(:grow).where.not('grows.grow_status': %i[done aborted])
  end

  def nb_weeks
    start_date.step(end_date, 7).count
  end

  def status_badge_class
    if done?
      'badge-light border'
    elsif aborted?
      'badge-danger'
    elsif seedling? || vegging? || flowering?
      'badge-success'
    elsif flushing?
      'badge-info'
    elsif drying? || curing?
      'badge-warning'
    else
      'badge-primary'
    end
  end

  def generate_weeks
    weeks.destroy_all

    return if start_date.nil?

    # create weeks
    sdate = start_date
    edate = sdate + 7.days
    index = 0

    seedling_weeks.times do |i|
      generate_weeks_with(:seedling, i, sdate, edate)
      sdate += 7.days
      edate = sdate + 7.days
      index += 1
    end

    vegging_weeks.times do |_i|
      generate_weeks_with(:vegging, index, sdate, edate)
      sdate += 7.days
      edate = sdate + 7.days
      index += 1
    end

    flowering_weeks.times do |_i|
      generate_weeks_with(:flowering, index, sdate, edate)
      sdate += 7.days
      edate = sdate + 7.days
      index += 1
    end

    flushing_weeks.times do |_i|
      generate_weeks_with(:flushing, index, sdate, edate)
      sdate += 7.days
      edate = sdate + 7.days
      index += 1
    end

    drying_weeks.times do |_i|
      generate_weeks_with(:drying, index, sdate, edate)
      sdate += 7.days
      edate = sdate + 7.days
      index += 1
    end

    curing_weeks.times do |_i|
      generate_weeks_with(:curing, index, sdate, edate)
      sdate += 7.days
      edate = sdate + 7.days
      index += 1
    end
  end

  def generate_weeks_with(type, index, start_date, end_date)
    Week.create(grow_id: id, week_type: type, week_number: index + 1, start_date:, end_date:)
  end

  def end_date
    return weeks.first.end_date if weeks.first

    start_date
  end

  def current_week
    now = Date.today
    # puts "#{start_date} < #{now} < #{end_date}"
    # return true if now >= start_date && now <= end_date
    weeks.where('? >= start_date AND ? <= end_date', now, now).first
  end

  def bg_color_for_week(week_index)
    days = week_index * 7
    week_start_date = start_date + days.days
    week_end_date = week_start_date + 7.days
    now = Date.today

    if now > week_end_date
      return 'success'

    elsif (week_start_date < now) && (now < week_end_date)
      return 'primary'
    end

    'secondary'
  end

  def progress_color
    now = Date.today

    return 'success' if done?
    return 'danger' if end_date.present? && now > end_date

    'primary'
  end

  def progress_percents
    # FIXME
    return
    start_time = start_date.to_time
    end_time = end_date.to_time

    return 100 if done?
    return 0 if !start_time || !end_time || (end_time == start_time)
    return 0 if Time.now < start_time

    r = (((Time.now - start_time) / (end_time - start_time)) * 100.0).round
    return 100 if r > 100

    r
  end

  def self.active_grows
    Grow.where.not('grows.grow_status': %i[done aborted])
  end

  def self.inactive_grows
    Grow.where('grows.grow_status': %i[done aborted])
  end

  def self.update_status
    active_grows = Grow.where.not('grows.grow_status': %i[done aborted])

    active_grows.each do |grow|
      next unless grow.auto_update_status?

      old_status = grow.grow_status

      if grow.current_week.seedling?
        grow.grow_status = :seedling
      elsif grow.current_week.vegging?
        grow.grow_status = :vegging
      elsif grow.current_week.flowering?
        grow.grow_status = :flowering
      elsif grow.current_week.flushing?
        grow.grow_status = :flushing
      elsif grow.current_week.drying?
        grow.grow_status = :drying
      elsif grow.current_week.curing?
        grow.grow_status = :curing
      end

      next unless old_status != grow.grow_status

      Event.create!(event_type: :cron,
                    message: "Grow <b>#{grow.description}</b> status updated to <b>#{grow.grow_status}</b>", eventable: grow)

      grow.save
    end
  end
end
