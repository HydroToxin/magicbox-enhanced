# frozen_string_literal: true

FactoryBot.define do
  factory :active_storage_attachment do
    name { "attachment_name" }
    record_type { "SomeRecordType" }
    record_id { 1 }
    association :blob, factory: :active_storage_blob
  end
end