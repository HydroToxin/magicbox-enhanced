# frozen_string_literal: true

FactoryBot.define do
  factory :alert_push_user do
    association :user
    association :alert
  end
end