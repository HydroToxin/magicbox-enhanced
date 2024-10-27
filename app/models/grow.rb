# frozen_string_literal: true

# Grow
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

  validates :birth_type, presence: true
  validates :description, presence: true
  validates :grow_status, presence: true
  validate :validate_number_of_subjects
  validate :validate_birth_type_and_mother

  def validate_number_of_subjects
    return unless birth_type == 'from_clone'
    return unless number_of_subjects.blank?

    errors.add(:number_of_subjects, "can't be blank when birth type is 'from clone'.")
  end

  def validate_birth_type_and_mother
    return unless birth_type == 'from_clone'

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
    (end_date - start_date).to_i / 7
  end

  def status_badge_class
    case grow_status
    when 'done'
      'badge-light border'
    when 'aborted'
      'badge-danger'
    when 'seedling', 'vegging', 'flowering'
      'badge-success'
    when 'flushing'
      'badge-info'
    when 'drying', 'curing'
      'badge-warning'
    else
      'badge-primary'
    end
  end

  def generate_weeks
    weeks.destroy_all

    return if start_date.nil?

    current_date = start_date
    end_date = current_date + 7.days
    week_index = 0

    %i[seedling vegging flowering flushing drying curing].each do |type|
      send(:"#{type}_weeks").times do
        generate_weeks_with_type(type, week_index, current_date, end_date)
        current_date += 7.days
        end_date = current_date + 7.days
        week_index += 1
      end
    end
  end

  def generate_weeks_with_type(type, index, start_date, end_date)
    Week.create(grow_id: id, week_type: type, week_number: index + 1, start_date:, end_date:)
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

  # rubocop:disable Lint/UnreachableCode
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
  # rubocop:enable Lint/UnreachableCode

  def self.active_grows
    Grow.where.not('grows.grow_status': %i[done aborted])
  end

  def self.inactive_grows
    Grow.where('grows.grow_status': %i[done aborted])
  end

  def self.update_status
    Grow.where.not(grow_status: %i[done aborted]).find_each do |grow|
      next unless grow.auto_update_status?

      old_status = grow.grow_status
      next if old_statusold_status == grow.grow_status = grow.current_week&.week_type&.to_sym
      next if old_status == grow.grow_status

      Event.create!(
        event_type: :cron,
        eventable: grow,
        message: "Grow <b>#{grow.description}</b> status updated to <b>#{grow.grow_status}</b>"
      )
      grow.save!
    end
  end
end
