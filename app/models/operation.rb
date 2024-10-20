# frozen_string_literal: true

class Operation < ApplicationRecord
  include DeviceTypeEnum

  belongs_to :condition_group

  def execute_operation(in_room)
    device = in_room.devices.where(device_type:).first

    return unless device

    if command == 'start'
      device.start(event_type: :cron, event: true)

      if duration && (duration != 0)
        MB_LOGGER.info "   -> #{device.name} started for #{duration} sec."
        CommandJob.perform_in(duration.seconds, device.id, 'stop')
      end
    elsif command == 'stop'
      device.stop(event_type: :cron, event: true)

      if duration && (duration != 0)
        MB_LOGGER.info "   -> #{device.name} stopped for #{duration} sec."
        CommandJob.perform_in(duration.seconds, device.id, 'start')
      end
    end
  end
end
