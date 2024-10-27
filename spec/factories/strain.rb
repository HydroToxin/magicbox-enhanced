# frozen_string_literal: true

FactoryBot.define do
  factory :strain do
    name { "Strain Name" }
    description { "Strain Description" }
    breeder { "Breeder" }
    location { "Location" }
    terpenes { "Terpenes" }
    effects { [] }
    ailments { [] }
    flavors { [] }
    strain_type { 'hybrid' }
    crosses { 'Blueberry x Haze' }
  end
end
