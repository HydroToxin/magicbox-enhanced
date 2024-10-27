# frozen_string_literal: true

FactoryBot.define do
  factory :resource do
    name { "Resource Name" }
    shortname { "Shortname" }
    choices {['Tap water', 'Mineral water', 'Purified water', 'Distiled water (reverse osmosis)'] }
    units { ['pH']}
    description { "Resource Description" }
    association :category
  end
end