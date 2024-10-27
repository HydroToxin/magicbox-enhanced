# frozen_string_literal: true

FactoryBot.define do
  factory :grow do
    description { "Grow Description" }
    start_date { Date.today }
    grow_status { 'seedling' }
    substrate { 'soil' }
    flowering { 'autoflowering' }
    birth_type { 'from_seed' }
    number_of_subjects { 1 }
    seedling_weeks { 1 }
    vegging_weeks { 2 }
    flowering_weeks { 3 }
    flushing_weeks { 4 }
    drying_weeks { 5 }
    curing_weeks { 6 }
    auto_update_status { true }
    estimated_weight_by_square_meter { 0 }
  end
end