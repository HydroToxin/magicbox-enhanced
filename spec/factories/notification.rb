# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    read { false }
    notify_email { true }
    association :user
    association :notified, factory: :alert
    association :notifiable, factory: :device
  end
end