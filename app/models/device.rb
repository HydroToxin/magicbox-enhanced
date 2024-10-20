class Device < ApplicationRecord
	include DeviceTypeEnum

  enum device_state: {
    :off    	  => 0,
    :on 	  	  => 1,
    :idle       => 2,
    :starting   => 3,
    :stopping   => 4
  }

  enum pin_type: {
    :digital		=> 0,
    :analog 		=> 1
  }

  belongs_to :room

  has_many :samples
  has_many :events, :as => :eventable
  has_many :devices_data_types
  has_many :data_types, through: :devices_data_types, source: :data_type
  has_many :notifications, as: :notified

  validates :name, presence: true

  def last_sample(data_type)
    samples.where(data_type: data_type).order(created_at: :desc).limit(1).first
  end


  def start(options={})
    default_options = {
      :event_type => :action,
      :event => true
    }

    options = options.reverse_merge(default_options)
    state_changed = self.off?

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
      self.save

      MB_LOGGER.tagged("Device-#{self.id}") do
        MB_LOGGER.info "  -> Start #{self.name} by #{options[:event_type]}"
      end

      if self.use_duration
        CommandJob.perform_in(self.default_duration.seconds, self.id, "stop", options[:event_type])

        Event.create!(event_type: options[:event_type], message: "<b>#{self.name}</b> started for <b>#{self.default_duration} sec</b> in <b>#{self.room.name}</b>.", eventable: self)
      else
        if options[:event_type] == :cron
          if state_changed
            Event.create!(event_type: :cron, message: "<b>#{self.name}</b> started in <b>#{self.room.name}</b>", eventable: self)
          end
        else
          if options[:event]
            Event.create!(event_type: :action, message: "<b>#{self.name}</b> started in <b>#{self.room.name}</b>", eventable: self)
          end
        end
      end

      return true
    rescue Exception => e
      return e
    end

    return false
  end

  def start_power_strip(options)
    begin
      if options[:event_type] == :cron
        if self.off?
          Event.create!(event_type: :cron, message: "<b>#{self.name}</b> started in <b>#{self.room.name}</b>", eventable: self)
        end
      else
        if options[:event]
          Event.create!(event_type: :action, message: "<b>#{self.name}</b> started in <b>#{self.room.name}</b>", eventable: self)
        end
      end

      output = %x(/usr/bin/sispmctl -o #{self.custom_identifier})
      return false if output.include?("No GEMBIRD")

      return true
    rescue Exception => e
      return e
    end
    return false
  end

  def stop_power_strip(options)
    begin
      if options[:event_type] == :cron
        if self.on?
          Event.create!(event_type: :cron, message: "<b>#{self.name}</b> stopped in <b>#{self.room.name}</b>", eventable: self)
        end
      else
        if options[:event]
          Event.create!(event_type: :action, message: "<b>#{self.name}</b> stopped in <b>#{self.room.name}</b>", eventable: self)
        end
      end

      output = %x(/usr/bin/sispmctl -f #{self.custom_identifier})
      return false if output.include?("No GEMBIRD")

      return true
    rescue Exception => e
      return e
    end

    return false
  end

  def stop(options={})
    default_options = {
      :event_type => :action,
      :event => true
    }

    options = options.reverse_merge(default_options)
    state_changed = self.on?

    logger.info options

    case device_type
    when 'power_strip'
      return stop_power_strip(options) if product_reference == 'silvershield_pms'
    end

    begin
      #RPi::GPIO.set_numbering :bcm
      #sleep 1
      #RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :low
      self.device_state = :off
      self.save

      MB_LOGGER.tagged("Device-#{self.id}") do
        MB_LOGGER.info "  -> Stop #{self.name} by #{options[:event_type]}"
      end

      if options[:event_type] == :cron
        if state_changed
          Event.create!(event_type: :cron, message: "<b>#{self.name}</b> stopped in <b>#{self.room.name}</b>", eventable: self)
        end
      else
        if options[:event]
          Event.create!(event_type: :action, message: "<b>#{self.name}</b> stopped in <b>#{self.room.name}</b>", eventable: self)
        end
      end
      return true
    rescue Exception => e
      return e
    end

    return false
  end

  def query_sensor
    if sensor? and pin_number > 0
      case product_reference
      when 'dht11'
        query_dht11
      when 'dht22'
        query_dht22
      end
      return true
    end
    return false
  end

  def query_dht22
    begin
      require "dht-sensor-ffi"
      result = DhtSensor.read(pin_number, 22)

      MB_LOGGER.info "# Query sensor: #{product_reference} (GPIO##{pin_number}) "
      MB_LOGGER.info  " -> Temp    : #{result.temperature.to_f.round(1).to_s}"
      MB_LOGGER.info  " -> Humidity: #{result.humidity.to_f.round.to_i.to_s}"

      temp_dt = DataType.find_by(name: "temperature")
      hum_dt  = DataType.find_by(name: "humidity")

      temp_s = result.temperature.to_f.round(1).to_s
      hum_s = result.humidity.to_f.round.to_i.to_s

      data_types << temp_dt if !data_types.include? temp_dt
      data_types << hum_dt  if !data_types.include? hum_dt

      Sample.create(
        device_id: id,
        product_reference: product_reference,
        data_type_id: temp_dt.id,
        value: temp_s,
        category_name: "sensor",
        html_color: "coral",
        unit: "°C"
      )

      Sample.create(
        device_id: id,
        product_reference: product_reference,
        data_type_id: hum_dt.id,
        value: hum_s,
        category_name: "sensor",
        html_color: "lightblue",
        unit: "%"
      )

      ActionCable.server.broadcast "dashboards_channel", temperature: "#{temp_s} °C"
      ActionCable.server.broadcast "dashboards_channel", humidity: "#{hum_s} °%"

    rescue Exception => e
      Rails.logger.error " -> failed    : MISSING_DATA"
      return e
    end
  end

  def query_dht11
    require 'dht11'

    dht = DHT11::Sensor.new(pin_number)

    result = dht.read

    MB_LOGGER.info "# Query sensor: #{product_reference} (GPIO##{pin_number}) "

    if result.error_code == :MISSING_DATA
      MB_LOGGER.info " -> failed    : MISSING_DATA"
      return false
    end

    # MB_LOGGER.info " -> Temp    : #{result.temperature}"
    # MB_LOGGER.info " -> Humidity: #{result.humidity}"
    MB_LOGGER.info " -> Temp    : #{dht.temp}"
    MB_LOGGER.info " -> Humidity: #{dht.humidity}"

    unless result.temperature.nan? and result.humidity.nan?
      temp_dt = DataType.find_by(name: "temperature")
      hum_dt  = DataType.find_by(name: "humidity")

      # yeah, add data_types to device here if needed
      data_types << temp_dt if !data_types.include? temp_dt
      data_types << hum_dt  if !data_types.include? hum_dt

      Sample.create(
        device_id: self.id,
        product_reference: self.product_reference,
        data_type_id: temp_dt.id,
        value: result.temperature,
        category_name: "sensor",
        html_color: "coral",
        unit: "°C")

      Sample.create(
        device_id: self.id,
        product_reference: self.product_reference,
        data_type_id: hum_dt.id,
        value: result.humidity,
        category_name: "sensor",
        html_color: "lightblue",
        unit: "%")
    end
  end

  def state_color
    if off?
      return "danger"
    elsif on?
      return "success"
    elsif idle?
      return "secondary"
    elsif starting? or stopping?
      return "warning"
    end
  end


  def pin_color
    if digital?
      return "info"
    elsif analog?
      return "success"
    end
  end

  def data_types_string
    data_types.map { |e| e.name.titleize  }.join(", ")
  end
end
