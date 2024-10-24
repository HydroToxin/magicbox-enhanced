FactoryBot.define do
  factory :scenario do
    name { "Scenario Name" }
    description { "Scenario Description" }
    enabled { false }
    scenarios { false }
    association :subject
  end
end