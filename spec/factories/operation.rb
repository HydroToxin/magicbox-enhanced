# frozen_string_literal: true

FactoryBot.define do
  factory :operation do
    command { "Command" }
    description { "Operation Description" }
    delay { 0 }
    retries { 0 }
    duration { 0 }
    device_type { 0 }
    association :condition_group
  end
end