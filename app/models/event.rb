# frozen_string_literal: true

# Event
class Event < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :eventable, polymorphic: true

  belongs_to :room, optional: true
  belongs_to :device, optional: true
  belongs_to :user, optional: true

  enum event_type: { action: 0, alert: 1, cron: 2, api: 3 }

  def badge_class
    if action?
      'secondary'
    elsif alert?
      'warning'
    elsif cron?
      'info'
    elsif api?
      'success'
    end
  end

  def text
    "#{event_type}: #{message}"
  end

  def start_date
    created_at
  end

  def end_date
    start_date + 1.hour
  end

  def color
    'lightblue'
  end

  # rubocop:disable Metrics/AbcSize
  def eventable_link
    case eventable_type
    when 'Room'
      helpers.link_to(eventable.name, room_path(eventable))
    when 'Device'
      raise 'Room not assigned' unless eventable.room

      helpers.link_to(eventable.room.name, room_path(eventable.room))
    when 'Subject'
      helpers.link_to(eventable.name, [eventable.grow, eventable])
    when 'Observation'
      helpers.link_to(eventable.grow.name, grow_path(eventable.grow))
    when 'Alert'
      # helpers.link_to(eventable.id, [:admin, eventable])
    end
  end
  # rubocop:enable Metrics/AbcSize

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def helpers
    ActionController::Base.helpers
  end

  # rubocop:disable Metrics/AbcSize
  def self.search(params)
    scope = Event.all

    scope = scope.where('message iLIKE ?', "%#{params[:message]}%") if params[:message].present?
    scope = scope.where(event_type: params[:event_type]) if params[:event_type].present?
    scope = scope.where(eventable_id: params[:room_id], eventable_type: 'Room') if params[:room_id].present?
    scope = scope.where(eventable_id: params[:grow_id], eventable_type: 'Grow') if params[:grow_id].present?
    scope = scope.where(eventable_id: params[:device_id], eventable_type: 'Device') if params[:device_id].present?

    scope
  end
  # rubocop:enable Metrics/AbcSize

  private

  def generate_eventable_path(eventable)
    case eventable.eventable_type
    when 'Room'
      Rails.application.routes.url_helpers.room_event_path(eventable.eventable_id, eventable.id)
    when 'Device'
      Rails.application.routes.url_helpers.device_event_path(eventable.eventable_id, eventable.id)
    else
      '#'
    end
  end
end
