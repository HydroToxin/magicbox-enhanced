# frozen_string_literal: true

class Device < ApplicationRecord
  include DeviceTypeEnum

  enum device_state: { off: 0, on: 1, idle: 2, starting: 3, stopping: 4 }

  enum pin_type: { digital: 0, analog: 1 }

  belongs_to :room

  has_many :samples, dependent: :delete_all
  has_many :events, as: :eventable
  has_many :devices_data_types, dependent: :delete_all
  has_many :data_types, through: :devices_data_types, source: :data_type
  has_many :notifications, as: :notified

  validates :name, presence: true

  def last_sample(data_type)
    samples.where(data_type:).order(created_at: :desc).limit(1).first
  end

  def start(options = {})
    default_options = { event_type: :action, event: true }

    options = options.reverse_merge(default_options)
    state_changed = off?

    logger.info options

    case device_type
    when 'power_strip'
      return start_power_strip(options) if product_reference == 'silvershield_pms'
    end

    begin
      # RPi::GPIO.set_numbering :bcm

      # sleep 1

      # RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :high

      self.device_state = :on
      save

      MB_LOGGER.tagged("Device-#{id}") do
        MB_LOGGER.info "  -> Start #{name} by #{options[:event_type]}"
      end

      if use_duration
        CommandJob.perform_in(default_duration.seconds, id, 'stop', options[:event_type])

        Event.create!(event_type: options[:event_type],
                      message: "<b>#{name}</b> started for <b>#{default_duration} sec</b> in <b>#{room.name}</b>.", eventable: self)
      elsif options[:event_type] == :cron
        if state_changed
          Event.create!(event_type: :cron, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
        end
      elsif options[:event]
        Event.create!(event_type: :action, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
      end

      return true
    rescue Exception => e
      return e
    end

    false
  end

  def start_power_strip(options)
    begin
      if options[:event_type] == :cron
        if off?
          Event.create!(event_type: :cron, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
        end
      elsif options[:event]
        Event.create!(event_type: :action, message: "<b>#{name}</b> started in <b>#{room.name}</b>", eventable: self)
      end

      output = `/usr/bin/sispmctl -o #{custom_identifier}`
      return false if output.include?('No GEMBIRD')

      return true
    rescue Exception => e
      return e
    end
    false
  end

  def stop_power_strip(options)
    begin
      if options[:event_type] == :cron
        if on?
          Event.create!(event_type: :cron, message: "<b>#{name}</b> stopped in <b>#{room.name}</b>", eventable: self)
        end
      elsif options[:event]
        Event.create!(event_type: :action, message: "<b>#{name}</b> stopped in <b>#{room.name}</b>", eventable: self)
      end

      output = `/usr/bin/sispmctl -f #{custom_identifier}`
      return false if output.include?('No GEMBIRD')

      return true
    rescue Exception => e
      return e
    end

    false
  end

  def stop(options = {})
    default_options = { event_type: :action, event: true }

    options = options.reverse_merge(default_options)
    state_changed = on?

    logger.info options

    case device_type
    when 'power_strip'
      return stop_power_strip(options) if product_reference == 'silvershield_pms'
    end

    begin
      # RPi::GPIO.set_numbering :bcm
      # sleep 1
      # RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :low
      self.device_state = :off
      save

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
      return true
    rescue Exception => e
      return e
    end

    false
  end

  def query_sensor
    if sensor? && pin_number.positive?
      case product_reference
      when 'dht11'
        query_dht11
      when 'dht22'
        query_dht22
      end
      return true
    end
    false
  end

  def query_dht22
    require 'dht-sensor-ffi'
    result = DhtSensor.read(pin_number, 22)

    MB_LOGGER.info "# Query sensor: #{product_reference} (GPIO##{pin_number}) "
    MB_LOGGER.info  " -> Temp    : #{result.temperature.to_f.round(1)}"
    MB_LOGGER.info  " -> Humidity: #{result.humidity.to_f.round.to_i}"

    temp_dt = DataType.find_by(name: 'temperature')
    hum_dt  = DataType.find_by(name: 'humidity')

    temp_s = result.temperature.to_f.round(1).to_s
    hum_s = result.humidity.to_f.round.to_i.to_s

    data_types << temp_dt unless data_types.include? temp_dt
    data_types << hum_dt  unless data_types.include? hum_dt

    Sample.create(
      device_id: id,
      product_reference:,
      data_type_id: temp_dt.id,
      value: temp_s,
      category_name: 'sensor',
      html_color: 'coral',
      unit: '°C'
    )

    Sample.create(
      device_id: id,
      product_reference:,
      data_type_id: hum_dt.id,
      value: hum_s,
      category_name: 'sensor',
      html_color: 'lightblue',
      unit: '%'
    )

  # ActionCable.server.broadcast "dashboards_channel", temperature: "#{temp_s} °C"
  # ActionCable.server.broadcast "dashboards_channel", humidity: "#{hum_s} °%"
  rescue Exception => e
    Rails.logger.error ' -> failed    : MISSING_DATA'
    e
  end

  def query_dht11
    require 'dht11'

    dht = DHT11::Sensor.new(pin_number)

    result = dht.read

    MB_LOGGER.info "# Query sensor: #{product_reference} (GPIO##{pin_number}) "

    if result.error_code == :MISSING_DATA
      MB_LOGGER.info ' -> failed    : MISSING_DATA'
      return false
    end

    # MB_LOGGER.info " -> Temp    : #{result.temperature}"
    # MB_LOGGER.info " -> Humidity: #{result.humidity}"
    MB_LOGGER.info " -> Temp    : #{dht.temp}"
    MB_LOGGER.info " -> Humidity: #{dht.humidity}"

    return if result.temperature.nan? && result.humidity.nan?

    temp_dt = DataType.find_by(name: 'temperature')
    hum_dt  = DataType.find_by(name: 'humidity')

    # yeah, add data_types to device here if needed
    data_types << temp_dt unless data_types.include? temp_dt
    data_types << hum_dt  unless data_types.include? hum_dt

    Sample.create(
      device_id: id,
      product_reference:,
      data_type_id: temp_dt.id,
      value: result.temperature,
      category_name: 'sensor',
      html_color: 'coral',
      unit: '°C'
    )

    Sample.create(
      device_id: id,
      product_reference:,
      data_type_id: hum_dt.id,
      value: result.humidity,
      category_name: 'sensor',
      html_color: 'lightblue',
      unit: '%'
    )
  end

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
end
