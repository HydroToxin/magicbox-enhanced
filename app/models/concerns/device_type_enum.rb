# frozen_string_literal: true

module DeviceTypeEnum
  extend ActiveSupport::Concern

  included do
    enum device_type: {
      unknow: 0,
      sensor: 1,
      fan: 2,
      water_pump: 3,
      air_pump: 4,
      light: 5,
      camera: 6,
      extractor: 7,
      intractor: 8,
      humidifier: 9,
      dehumidifier: 10,
      power_strip: 11,
      heater: 12,
      custom_2: 99,
      custom_3: 100
    }
  end
end
