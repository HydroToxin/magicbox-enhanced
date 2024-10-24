# frozen_string_literal: true

FactoryBot.define do
  factory :active_storage_blob do
    key { SecureRandom.uuid }
    filename { "example.jpg" }
    content_type { "image/jpeg" }
    service_name { "local" }
    string { "some_string" }
    byte_size { 1024 }
  end
end