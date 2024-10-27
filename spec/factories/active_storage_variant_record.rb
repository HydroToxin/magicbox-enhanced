# frozen_string_literal: true

FactoryBot.define do
  factory :active_storage_variant_record do
    variation_digest { "digest" }
    association :blob, factory: :active_storage_blob
  end
end