# frozen_string_literal: true

FactoryBot.define do
  factory :observation do
    name { "Observation Name" }
    body { "Observation Body" }
    water { 0.0 }
    nutrients { 0.0 }
    duration { 0 }
    association :user
    association :grow
    association :room
  end
end