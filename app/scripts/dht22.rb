class Dht22 < Base
  def perform

    MB_LOGGER.info "# Query DHT22 sensor:"

    unless RUBY_PLATFORM.include?('linux')
      MB_LOGGER.info ' -> failed    : Current Platform nor supported.'
      return
    end

    component = device.component
    circuit = component.circuit

    raspberry_pi = circuit.component_connections.first.source_component
    dht22 = circuit.component_connections.first.target_component

    return unless (raspberry_pi && raspberry_pi.microcontroller?) &&
      (dht22 && dht22.sensor?)


    unless device.data_types.include? ['temperature', 'humidity']
      MB_LOGGER.info ' -> failed    : Device is not configured for temperature and humidity'
      return false
    end

    require 'dht-sensor-ffi'

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
end
