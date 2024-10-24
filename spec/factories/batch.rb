# frozen_string_literal: true

FactoryBot.define do
  factory :batch do
    name { "Batch Name" }
    total_weight { 100.0 }
    batch_weight { 10.0 }
    price_per_weight { 5.0 }
    batch_price { 50.0 }
    batch_count { 10 }
    batch_type { 'trim' }
    association :harvest
    association :grow

  end
end