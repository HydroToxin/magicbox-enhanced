# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    read { false }
    notify_email { true }
    notifiable_type { "SomeType" }
    notifiable_uuid { SecureRandom.uuid }
    notifications_type { "SomeType" }
    notifications_id { 1 }
    notified_type { "SomeType" }
    notified_id { 1 }
    association :user
  end
end