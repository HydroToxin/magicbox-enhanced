# frozen_string_literal: true

FactoryBot.define do
  factory :grow do
    description { "Grow Description" }
    start_date { Date.today }
    grow_status { 'seedling' }
  end
end