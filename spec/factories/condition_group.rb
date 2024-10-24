# frozen_string_literal: true

FactoryBot.define do
  factory :condition_group do
    name { "Condition Group Name" }
    enabled { true }
    association :scenario
  end
end