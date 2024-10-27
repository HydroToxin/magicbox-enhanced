# frozen_string_literal: true

FactoryBot.define do
  factory(:week) do
    week_number { 1 }
    week_type { 'seedling' }
    start_date { Time.now }
    end_date { Time.now }
    uuid  { SecureRandom.uuid }
    association :grow
  end
end