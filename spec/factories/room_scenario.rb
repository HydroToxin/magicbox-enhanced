# frozen_string_literal: true

FactoryBot.define do
  factory :room_scenario do
    association :room
    association :scenario
  end
end