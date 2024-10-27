# frozen_string_literal: true

# Operation
class Operation < ApplicationRecord
  include DeviceTypeEnum

  belongs_to :condition_group

  validates :command, presence: true

  def execute_operation(room)
    device = room.devices.find_by(device_type:)

    return unless device

    case command
    when 'start'
      device.start(event_type: :cron, event: true)
      schedule_opposite_command(device, duration) if duration.positive?
    when 'stop'
      device.stop(event_type: :cron, event: true)
      schedule_opposite_command(device, duration) if duration.positive?
    end
  end

  private

  def schedule_opposite_command(device, duration)
    CommandJob.perform_in(duration.seconds, device.id, opposite_command)
  end

  def opposite_command
    command == 'start' ? 'stop' : 'start'
  end
end
