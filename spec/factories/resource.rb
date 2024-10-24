# frozen_string_literal: true

FactoryBot.define do
  factory :resource do
    name { "Resource Name" }
    shortname { "Shortname" }
    choices { [] }
    units { [] }
    description { "Resource Description" }
    association :category
  end
end