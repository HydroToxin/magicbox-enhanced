# frozen_string_literal: true

FactoryBot.define do
  factory :observations_subject do
    association :observation
    association :subject
  end
end