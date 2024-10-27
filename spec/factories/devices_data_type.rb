# frozen_string_literal: true

FactoryBot.define do
  factory :devices_data_type do
    association :device
    association :data_type
  end
end