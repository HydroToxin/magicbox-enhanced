# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    event_type { "action" }
    message { "Event Message" }
    data { {} }
    association :room
    association :device
    association :user
    association :eventable, factory: :device
  end
end