# frozen_string_literal: true

FactoryBot.define do
  factory :alert do
    alert_type { 'resource_alert' }
    operator { 'equal' }
    enabled { true }
    push_enabled { false }
    value { 100.0 }
    message { "Alert message" }
    association :data_type
    association :resource
  end
end