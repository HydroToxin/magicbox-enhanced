# frozen_string_literal: true

FactoryBot.define do
  factory :harvest do
    harvested_trim_weight { 10.0 }
    harvested_waste_weight { 5.0 }
    harvested_bud_weight { 20.0 }
    dry_trim_weight { 8.0 }
    dry_bud_weight { 18.0 }
    association :grow
  end
end