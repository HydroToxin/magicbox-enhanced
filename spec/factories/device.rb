# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    device_type { 'sensor' }
    device_state { 'on' }
    default_duration { 1 }
    name { "Device Name" }
    product_reference { "Product Ref" }
    custom_identifier { "Custom ID" }
    description { "Device Description" }
    use_duration { false }
    association :room
  end
end