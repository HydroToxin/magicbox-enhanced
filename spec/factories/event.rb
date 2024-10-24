# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    event_type { 1 }
    message { "Event Message" }
    data { {} }
    association :room
    association :device
    association :user
  end
end