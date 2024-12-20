# frozen_string_literal: true

FactoryBot.define do
  factory :observation_resource do
    value { 'Value' }
    unit { 'Unit' }
    association :resource
    association :observation
    # association :subject
  end
end
