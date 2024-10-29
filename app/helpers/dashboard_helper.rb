# frozen_string_literal: true

require 'os'

# DashboardHelper
module DashboardHelper

  def last_sample(name:)
    return 0 if DataType.find_by(name: name).nil?

    last = Sample.where(product_reference: 'System',
                        data_type_id: DataType.find_by(name: name).id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
  end

  def cpu_temp
    return 0 if DataType.find_by(name: 'cpu_temp').nil?

    last = Sample.where(product_reference: 'System',
                        data_type_id: DataType.find_by(name: 'cpu_temp').id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last

    '0°C'
  end

  def cpu_usage
    return 0 if DataType.find_by(name: 'cpu_usage').nil?

    last = Sample.where(product_reference: 'System',
                        data_type_id: DataType.find_by(name: 'cpu_usage').id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last

    '0%'
  end

  def used_memory
    return 0 if DataType.find_by(name: 'memory_used').nil?

    last = Sample.where(product_reference: 'System',
                        data_type_id: DataType.find_by(name: 'memory_used').id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last

    '0 Mb'
  end

  def free_memory
    return 0 if DataType.find_by(name: 'memory_free').nil?

    last = Sample.where(product_reference: 'System',
                        data_type_id: DataType.find_by(name: 'memory_free').id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last

    '0 Mb'
  end

  def voltage
    return 0 if DataType.find_by(name: 'cpu_voltage').nil?

    last = Sample.where(product_reference: 'System',
                        data_type_id: DataType.find_by(name: 'cpu_voltage').id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last

    '0V'
  end

  def system_info
    if OS.mac?
      'macOS'
    else
      `/usr/bin/lsb_release -d`.split(':')[1].strip
    end
  end

  def hard_info
    if OS.mac?
      'Apple'
    else
      `cat /sys/firmware/devicetree/base/model`
    end
  end

  def uptime_info
    if OS.mac?
      'Shitty'
    else
      `uptime -p`
    end
  end

  def weather_temp
    return 0 if DataType.find_by(name: 'weather_temperature').nil?

    last = Sample.where(
      product_reference: 'Openweather2',
      data_type: DataType.find_by(name: 'weather_temperature')
    ).order(created_at: :asc).limit(1).first

    return "#{last.value}#{last.unit}" if last

    '0°C'
  end

  def weather_humidity
    return 0 if DataType.find_by(name: 'weather_humidity').nil?

    last = Sample.where(
      product_reference: 'Openweather2',
      data_type: DataType.find_by(name: 'weather_humidity')
    ).order(created_at: :asc).limit(1).first

    return "#{last.value}#{last.unit}" if last

    '0%'
  end

  def kwh_cost_estimation(kwh)
    (Magicbox::Application::KWH_COST * kwh).round(2)
  end

  def total_watts
    Room.all.inject(0) { |sum, room| sum + room.total_watts }.round(2)
  end

  def total_kwh_day
    Room.all.inject(0) { |sum, room| sum + room.kwh_day }.round(2)
  end

  def total_kwh_month
    Room.all.inject(0) { |sum, room| sum + room.kwh_month }.round(2)
  end
end
