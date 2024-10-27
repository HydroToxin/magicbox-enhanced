# frozen_string_literal: true

FactoryBot.define do
  factory :condition do
    predicate { 1 }
    target_value { 100 }
    condition_type { 'time_duration' }
    logic { 'and_operator' }
    duration { 125 }
    start_time { "08:00" }
    end_time { "12:00" }
    last_duration_checked_at { Time.now }
    time_duration_hours { 0 }
    time_duration_minutes { 0 }
    association :data_type
    association :condition_group
  end
end