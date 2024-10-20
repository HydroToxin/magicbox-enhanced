# frozen_string_literal: true

namespace :process do
  desc 'Process all'
  task run: :environment do
    # Query sensor for each devices registered as :sensor type
    Device.all.each do |d|
      if d.sensor?
        d.query_sensor
        sleep 6
      end
    end

    # trigger alerts if defined
    Alert.trigger

    # run enabled scenarios
    Scenario.run2

    # process TODO notifications
    Todo.notify

    # update grows statuses
    Grow.update_status

    # query some general metrics
    cpu_temp = if OS.mac?
                 `sysctl -n machdep.xcpm.cpu_thermal_level`.to_f.round(1)
               else
                 `/usr/bin/vcgencmd measure_temp`.to_s.split('=')[1].to_f.round(1)
               end

    # ActionCable.server.broadcast "dashboards_channel", cpu_temp: "#{cpu_temp.to_s}°C"
    cpu_usage = if OS.mac?
                  `ps -A -o %cpu | awk '{s+=$1} END {print s}'`
                else
                  `/bin/grep 'cpu ' /proc/stat | /usr/bin/awk \
                  '{usage=100-($5*100)/($2+$3+$4+$5+$6+$7+$8)} END {print usage}'`.to_f.round(1)
                end

    # ActionCable.server.broadcast "dashboards_channel", cpu_usage: "#{cpu_usage.to_s}%"
    cpu_voltage = if OS.mac?
                    `system_profiler SPPowerDataType | grep Voltage`.split(': ')[1].to_i / 1000
                  else
                    `/usr/bin/vcgencmd measure_volts`.split('=')[1].to_f.round(1)
                  end

    # ActionCable.server.broadcast "dashboards_channel", cpu_voltage: "#{cpu_voltage.to_s}V"
    used_memory = if OS.mac?
                    '0 Mi'
                  else
                    `free -h | grep Mem | awk '{print $3}'`.chomp
                  end

    # ActionCable.server.broadcast "dashboards_channel", used_memory: used_memory
    free_memory = if OS.mac?
                    '0 Mi'
                  else
                    `free -h | grep Mem | awk '{print $4}'`.chomp
                  end

    # ActionCable.server.broadcast "dashboards_channel", free_memory: free_memory

    Sample.create(
      product_reference: 'System',
      data_type_id: DataType.find_by(name: 'cpu_temp').id,
      value: cpu_temp,
      category_name: 'cpu',
      html_color: 'red',
      unit: '°C'
    )

    Sample.create(
      product_reference: 'System',
      data_type_id: DataType.find_by(name: 'cpu_usage').id,
      value: cpu_usage,
      category_name: 'cpu',
      html_color: 'lightgray',
      unit: '%'
    )

    Sample.create(
      product_reference: 'System',
      data_type_id: DataType.find_by(name: 'cpu_voltage').id,
      value: cpu_voltage,
      category_name: 'cpu',
      html_color: 'darkgray',
      unit: 'V'
    )

    Sample.create(
      product_reference: 'System',
      data_type_id: DataType.find_by(name: 'memory_used').id,
      value: used_memory,
      category_name: 'memory',
      html_color: 'lightgreen'
    )

    Sample.create(
      product_reference: 'System',
      data_type_id: DataType.find_by(name: 'memory_free').id,
      value: free_memory,
      category_name: 'memory',
      html_color: 'lightblue'
    )

    require 'openweather2'

    begin
      Openweather2.configure do |config|
        config.endpoint = Setting.openweather_endpoint
        config.apikey = ENV.fetch('OPENWEATHER2_API_KEY')
      end

      info = Openweather2.get_weather(city: Setting.openweather_city, units: 'metric')

      puts info.inspect

      if info
        Sample.create(
          product_reference: 'Openweather2',
          data_type_id: DataType.find_or_create_by(name: 'weather_temperature').id,
          value: info.temperature,
          category_name: 'weather',
          html_color: 'red',
          unit: '°C'
        )

        Sample.create(
          product_reference: 'Openweather2',
          data_type_id: DataType.find_or_create_by(name: 'weather_humidity').id,
          value: info.humidity,
          category_name: 'weather',
          html_color: 'lightskyblue',
          unit: '%'
        )

        Sample.create(
          product_reference: 'Openweather2',
          data_type_id: DataType.find_or_create_by(name: 'weather_pressure').id,
          value: info.pressure,
          category_name: 'weather',
          html_color: 'yellow',
          unit: 'hPa'
        )

        Sample.create(
          product_reference: 'Openweather2',
          data_type_id: DataType.find_or_create_by(name: 'weather_clouds').id,
          value: info.clouds,
          category_name: 'weather',
          html_color: 'gray',
          unit: '%'
        )

        Sample.create(
          product_reference: 'Openweather2',
          data_type_id: DataType.find_or_create_by(name: 'weather_wind_speed').id,
          value: info.wind_speed,
          category_name: 'weather',
          html_color: '#98FF98',
          unit: 'km/s'
        )

        Sample.create(
          product_reference: 'Openweather2',
          data_type_id: DataType.find_or_create_by(name: 'weather_wind_angle').id,
          value: info.wind_angle,
          category_name: 'weather',
          html_color: '#FFF380',
          unit: '°'
        )

      end

      # take room picture
      Room.all.each do |r|
        # r.take_camshot
      end
    rescue StandardError => e
      puts e.inspect
    end
  end
end
