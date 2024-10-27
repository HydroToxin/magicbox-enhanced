FactoryBot.define do
  factory :subject do
    name { "Subject Name" }
    birth_type { 'from_clone' }
    association :grow
    association :strain
    association :room

    transient do
      mother_depth { 0 }
    end

    after(:build) do |subject, evaluator|
      if evaluator.mother_depth > 0
        subject.mother = build(:subject, mother_depth: evaluator.mother_depth - 1)
      end
    end
  end
end