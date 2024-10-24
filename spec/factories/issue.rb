# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    severity { 1 }
    issue_type { 1 }
    issue_status { 1 }
    association :resource
    association :subject
    association :observation
  end
end