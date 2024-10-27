# frozen_string_literal: true

# Room
class Room < ApplicationRecord
  attr_accessor :scenario_id

  has_many :subjects
  has_many :devices, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy

  has_many :observations, through: :subjects

  has_many :samples, through: :devices

  has_many :room_scenarios, dependent: :destroy
  has_many :scenarios, through: :room_scenarios

  validates :name, presence: true

  enum room_type: { box: 0, closet: 1, room: 2, greenhouse: 3 }

  has_many_attached :camshots

  def all_events
    Event.where(eventable_type: 'Device', eventable_id: devices)
         .or(Event.where(eventable_type: 'Room', eventable_id: id))
  end

  def active_subjects
    subjects.joins(:grow).where.not('grows.grow_status': %i[done aborted])
  end

  def last_sample(data_type)
    samples.where(data_type:).order(created_at: :desc).limit(1).first
  end

  def current_temperature
    data_type = DataType.where(name: 'temperature').first

    sample = last_sample(data_type)

    return nil if sample.nil?

    "#{sample.value} #{sample.unit}"
  end

  def current_humidity
    data_type = DataType.where(name: 'humidity').first

    sample = last_sample(data_type)

    return nil if sample.nil?

    "#{sample.value} #{sample.unit}"
  end

  def total_watts
    w = 0

    devices.each do |device|
      w += device.watts if device.watts && device.watts > 0.0
    end

    w.round(2)
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def kwh_day
    total_kwh = 0

    scenarios.each do |scenario|
      next unless scenario.enabled?

      scenario.condition_groups.each do |condition_group|
        condition_group.operations.each do |operation|
          next unless operation.command == 'start'

          # running_time = calculate_running_time(condition_group)
          running_time = 24

          next unless running_time.positive?

          device = devices.find_by(device_type: operation.device_type)
          total_kwh += running_time * device.watts / 1000 if device
        end
      end
    end

    total_kwh.round(2)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def kwh_month
    kd = kwh_day
    return (kd * 30).round(2) if kd.positive?

    0
  end

  private

  def calculate_running_time(condition_group)
    running_time = 24

    condition_group.conditions.where(condition_type: :date).each do |condition|
      running_time = (condition.end_time - condition.start_time).abs / 3600
    end

    running_time
  end

  # def take_camshot
  # 	# Get the first camera device
  # 	camera_device = devices.where(device_type: :camera).first
  # 	return unless camera_device

  # 	# Generate temporary image path
  # 	tmp_name = "camshot-image-#{Time.now.to_i}"
  # 	tmp_image_path = "/tmp/#{tmp_name}.jpeg"

  # 	begin
  # 		# Capture image based on the type of camera device
  # 		case camera_device.product_reference
  # 		when "usb_webcam"
  # 			# Capture image from USB webcam with fswebcam
  # 			system("/usr/bin/fswebcam -d /dev/video0 --flip v --no-banner -r 384x288 #{tmp_image_path}")
  # 		when "rpi_camera_module_v2"
  # 			# No implementation as per original code
  # 		when "ustreamer"
  # 			# Capture image from ustreamer
  # 			system("curl http://magicbox.read-write.fr:8888/snapshot -o #{tmp_image_path}")
  # 		else
  # 			return # Exit method if no known camera type is matched
  # 		end

  # 		# Attach the image to the camshots collection
  # 		if File.exist?(tmp_image_path)
  # 			self.camshots.attach(io: File.open(tmp_image_path), filename: "image-#{Time.now.strftime('%s%L')}.jpeg")
  # 			# Delete the temporary file
  # 			File.delete(tmp_image_path)
  # 		else
  # 			puts "Failed to create image file: #{tmp_image_path}"
  # 		end
  # 	rescue => e
  # 		Rails.logger.error "Error taking camshot: #{e.message}"
  # 	ensure
  # 		# Ensure the temporary file is deleted even if errors occur
  # 		File.delete(tmp_image_path) if File.exist?(tmp_image_path)
  # 	end
  # end

  def dark?
    require 'rmagick'
    active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: "#{Rails.root}/storage/")
    path = active_storage_disk_service.send(:path_for, camshots.last.blob.key)

    img = Magick::Image.read(path).first
    puts img.channel_mean

    return true if (img.channel_mean[0] <= 7000) && (img.channel_mean[1] <= 1000)

    false
  end
end
