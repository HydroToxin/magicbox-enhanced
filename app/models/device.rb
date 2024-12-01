# frozen_string_literal: true

# Device
# rubocop:disable Metrics/ClassLength
class Device < ApplicationRecord
  include DeviceTypeEnum

  enum device_state: { off: 0, on: 1, idle: 2, starting: 3, stopping: 4 }

  belongs_to :room
  belongs_to :component, optional: true
  belongs_to :device_script, optional: true

  has_many :samples, dependent: :delete_all
  has_many :events, as: :eventable
  has_many :devices_data_types, dependent: :delete_all
  has_many :data_types, through: :devices_data_types, source: :data_type
  has_many :notifications, as: :notified

  validates :name, presence: true

  accepts_nested_attributes_for :devices_data_types,
    allow_destroy: true,
    reject_if: :all_blank


  def script
    return if device_script.nil?

    device_script.name.downcase.classify.safe_constantize.call(self)
  end

  def last_sample(data_type)
    samples.where(data_type:).order(created_at: :desc).limit(1).first
  end

  # rubocop:disable Metrics/MethodLength,  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def start(options = {})
    default_options = { event_type: :action, event: true }

    options = options.reverse_merge(default_options)
    state_changed = off?

    case device_type
    when 'power_strip'
      return start_power_strip(options) if product_reference == 'silvershield_pms'
    end

    begin
      # RPi::GPIO.set_numbering :bcm
      # sleep 1
      # RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :high

      update(device_state: :on)

      MB_LOGGER.tagged("Device-#{id}") do
        MB_LOGGER.info "  -> Start #{name} by #{options[:event_type]}"
      end

      if use_duration
        CommandJob.perform_in(default_duration.seconds, id, 'stop', options[:event_type])

        Event.create!(event_type: options[:event_type],
                      message: "<b>#{name}</b> started for <b>#{default_duration} sec</b> in <b>#{room.name}</b>.",
                      eventable: self)
      elsif options[:event_type] == :cron
        if state_changed
          Event.create!(event_type: :cron, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
        end
      elsif options[:event]
        Event.create!(event_type: :action, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
      end

      true
    rescue StandardError
      false
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def start_power_strip(options)
    if options[:event_type] == :cron
      if off?
        Event.create!(event_type: :cron, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
      end
    elsif options[:event]
      Event.create!(event_type: :action, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
    end

    output = `/usr/bin/sispmctl -o #{custom_identifier}`
    return false if output.include?('No GEMBIRD')

    true
  rescue StandardError
    false
  end

  def stop_power_strip(options)
    if options[:event_type] == :cron
      Event.create!(event_type: :cron, message: "<b>#{name}</b> stopped in <b>#{room.name}</b>", eventable: self) if on?
    elsif options[:event]
      Event.create!(event_type: :action, message: "<b>#{name}</b> stopped in <b>#{room.name}</b>", eventable: self)
    end

    output = `/usr/bin/sispmctl -f #{custom_identifier}`
    return false if output.include?('No GEMBIRD')

    true
  rescue StandardError
    false
  end

  # rubocop:disable Metrics/MethodLength
  def stop(options = {})
    default_options = { event_type: :action, event: true }

    options = options.reverse_merge(default_options)
    state_changed = on?

    case device_type
    when 'power_strip'
      return stop_power_strip(options) if product_reference == 'silvershield_pms'
    end

    begin
      # RPi::GPIO.set_numbering :bcm
      # sleep 1
      # RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :low
      update(device_state: :off)

      MB_LOGGER.tagged("Device-#{id}") do
        MB_LOGGER.info "  -> Stop #{name} by #{options[:event_type]}"
      end

      if options[:event_type] == :cron
        if state_changed
          Event.create!(event_type: :cron, message: "<b>#{name}</b> stopped in <b>#{room.name}</b>", eventable: self)
        end
      elsif options[:event]
        Event.create!(event_type: :action, message: "<b>#{name}</b> stopped in <b>#{room.name}</b>", eventable: self)
      end
      true
    rescue StandardError
      false
    end
  end
  # rubocop:enable Metrics/MethodLength

  def query_sensor

  end

  # rubocop:disable Metrics/MethodLength
  def query_dht22
  #   require 'dht-sensor-ffi'

  #   temperature_type = DataType.find_by(name: 'temperature')
  #   humidity_type = DataType.find_by(name: 'humidity')

  #   # return false if device is not configured for temperature and humidity
  #   if data_types.include?(temperature_type) && data_types.include?(humidity_type)
  #     MB_LOGGER.info ' -> failed    : Device is not configured for temperature and humidity'
  #     return false
  #   end

  #   result = DhtSensor.read(pin_number, 22)

  #   temperature = result.temperature.to_f.round(1).to_s
  #   humidity = result.humidity.to_f.round.to_i.to_s

  #   MB_LOGGER.info "# Query sensor:"
  #   MB_LOGGER.info  " -> Temp    : #{temperature}"
  #   MB_LOGGER.info  " -> Humidity: #{humidity}"

  #   create_sample(temperature_type, temperature, 'sensor', 'coral', '°C')
  #   create_sample(humidity_type, humidity, 'sensor', 'lightblue', '%')

  #   # ActionCable.server.broadcast "dashboards_channel", temperature: "#{temp_s} °C"
  #   # ActionCable.server.broadcast "dashboards_channel", humidity: "#{hum_s} °%"

  #   true
  # rescue StandardError
  #   Rails.logger.error ' -> failed    : MISSING_DATA'
  #   false
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/MethodLength
  def query_dht11
    # require 'dht11'

    # MB_LOGGER.info "# Query sensor:"

    # temperature_type = DataType.find_by(name: 'temperature')
    # humidity_type = DataType.find_by(name: 'humidity')

    # # return false if device is not configured for temperature and humidity
    # if data_types.include?(temperature_type) && data_types.include?(humidity_type)
    #   MB_LOGGER.info ' -> failed    : Device is not configured for temperature and humidity'
    #   return false
    # end

    # sensor = DHT11::Sensor.new(pin_number)
    # reading = sensor.read

    # # return false if sensor raise an error or
    # if reading.error_code == :MISSING_DATA
    #   MB_LOGGER.info ' -> failed    : MISSING_DATA'
    #   return false
    # end

    # temperature = reading.temperature
    # humidity = reading.humidity

    # MB_LOGGER.info " -> Temp    : #{sensor.temp}"
    # MB_LOGGER.info " -> Humidity: #{sensor.humidity}"

    # # return false if no sensor data available
    # if temperature.nan? && humidity.nan?
    #   MB_LOGGER.info ' -> failed    : No sensor data available.'
    #   return false
    # end

    # create_sample(temperature_type, temperature, 'sensor', 'coral', '°C')
    # create_sample(humidity_type, humidity, 'sensor', 'lightblue', '%')

    # true
  end
  # rubocop:enable Metrics/MethodLength

  def state_color
    if off?
      'danger'
    elsif on?
      'success'
    elsif idle?
      'secondary'
    elsif starting? || stopping?
      'warning'
    end
  end

  def pin_color
    if digital?
      'info'
    elsif analog?
      'success'
    end
  end

  def data_types_string
    data_types.map { |e| e.name.titleize }.join(', ')
  end

  private

  def create_sample(data_type, value, category_name, html_color, unit)
    Sample.create(device: self, product_reference:, data_type:, value:, category_name:, html_color:, unit:)
  end
end
# rubocop:enable Metrics/ClassLength
