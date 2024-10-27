# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    device_type { 'sensor' }
    device_state { 'on' }
    pin_type { 'digital' }
    pin_number { 1 }
    default_duration { 1 }
    name { "Device Name" }
    product_reference { "Product Ref" }
    custom_identifier { "Custom ID" }
    watts { 100.0 }
    volts { 220.0 }
    amperes { 0.5 }
    description { "Device Description" }
    use_duration { false }
    association :room
  end
end