# frozen_string_literal: true

require 'dotiw'

class Condition < ApplicationRecord
  include ApplicationHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::NumberHelper

  attr_accessor :time_duration_hours, :time_duration_minutes

  belongs_to :condition_group
  belongs_to :data_type

  enum condition_type: { date: 0, time_duration: 4, data_type: 1, resource: 2, device_state: 3 }

  enum logic: { and_operator: 0, or_operator: 1 }

  # after_validation :compute_duration

  after_initialize do |condition|
    if condition.duration
      self.time_duration_hours = condition.duration / 60
      self.time_duration_minutes = condition.duration % 60
    end
  end

  after_find do |condition|
    if condition.duration
      Time.at(condition.duration).utc
      self.time_duration_hours = condition.duration / 60
      self.time_duration_minutes = condition.duration % 60
    end
  end

  def self.condition_type_text(c)
    return 'Time Range' if c == :date

    c.to_s.titleize
  end

  def self.logic_text(l)
    return 'AND' if l == :and_operator

    'OR'
  end

  def check_condition(room)
    if date?
      now = Time.now

      check_between = need_check_between
      between = cron_between_is_valid(now)

      return true if !check_between || (check_between && between)
    elsif time_duration?
      self.last_duration_checked_at = created_at unless last_duration_checked_at
      now = Time.now.utc

      if last_duration_checked_at + (duration * 60) < now
        self.last_duration_checked_at = now
        save
        return true
      end
    elsif data_type?
      return true if check_data_type_for_room(room)

    end

    false
  end

  def condition_text
    if date?
      return "<b>current time (#{ftime(Time.now)})</b> is between <b>#{ftime(start_time)}</b> and <b>#{ftime(end_time)}</b>"
    elsif data_type?
      return "<b>#{data_type.name}</b> is <b>#{[['>=', 0], ['<=', 1]][predicate].first}</b> to <b>#{target_value}</b>"
    elsif time_duration?
      return "not ran since <b>#{distance_of_time_in_words(duration * 60)}</b>"
    end

    'unknow condition'
  end

  def check_data_type_for_room(room)
    return true unless data_type

    sample = room.samples.where(data_type_id: data_type.id).order('created_at').first
    return true unless sample

    # logger.info "check_data_type_for_room : #{sample.inspect}"

    # [">=", 0], ["<=", 1]
    if predicate.zero?
      return true if sample.value.to_f >= target_value.to_f
    elsif predicate == 1
      return true if sample.value.to_f <= target_value.to_f
    end

    false
  end

  def is_yesterday(now)
    return false if start_time.hour < end_time.hour

    return true if now.hour < end_time.hour

    return false if now.hour > end_time.hour

    return true if now.min < end_time.min

    false
  end

  def is_tomorrow
    return true if start_time.hour > end_time.hour

    return false if start_time.hour < end_time.hour

    return true if start_time.min > end_time.min

    return false if start_time.min < end_time.min

    true
  end

  def cron_between_is_valid(now)
    return true if !start_time || !end_time

    return true if start_time == end_time

    start_date  = now.change({ hour: start_time.hour, min: start_time.min, sec: start_time.sec })
    end_date    = now.change({ hour: end_time.hour, min: end_time.min, sec: end_time.sec })

    start_is_yesterday = is_yesterday(now)

    if start_is_yesterday
      start_date -= 1.day
    elsif is_tomorrow
      end_date += 1.day
    end

    now.between?(start_date, end_date)
  end

  def need_check_between
    return false unless start_time

    return false unless end_time

    true
  end

  def has_valid_period(now)
    # return true if !last_exec_time

    # logger.info last_exec_time

    seconds_elapsed = now - last_exec_time

    # logger.info seconds_elapsed
    # logger.info time_value.minutes

    return seconds_elapsed >= time_value.minutes if minute?

    return seconds_elapsed >= time_value.hours if hour?

    return seconds_elapsed >= time_value.days if day?

    false
  end

  def compute_duration
    d = nil

    if time_duration_hours && time_duration_minutes
      d = (time_duration_hours * 60) + time_duration_minutes
    elsif time_duration_hours
      d = (time_duration_hours * 60)
    elsif time_duration_minutes
      d = time_duration_minutes
    end

    d
  end
end
