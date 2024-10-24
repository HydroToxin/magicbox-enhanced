# frozen_string_literal: true

FactoryBot.define do
  factory :condition do
    predicate { 1 }
    target_value { 100 }
    condition_type { 0 }
    logic { 0 }
    duration { 60 }
    start_time { "08:00" }
  end
end