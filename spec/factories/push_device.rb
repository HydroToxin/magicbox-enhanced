# frozen_string_literal: true

FactoryBot.define do
  factory :push_device do
    association :device
    association :user
  end
end