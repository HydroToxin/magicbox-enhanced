FactoryBot.define do
  factory :scenario do
    name { "Scenario Name" }
    description { "Scenario Description" }
    enabled { false }
    scenarios { false }
    association :subject

    trait :with_condition_groups do
      after(:create) do |scenario|
        create_list(:condition_group, 3, scenario: scenario)
      end
    end
  end
end