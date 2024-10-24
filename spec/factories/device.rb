# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    device_type { 1 }
    device_state { 1 }
    pin_type { 0 }
    pin_number { 0 }
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