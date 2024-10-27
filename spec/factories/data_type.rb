# frozen_string_literal: true

FactoryBot.define do
  factory :data_type do
    name { "temperatue" }

    factory :data_type_with_samples do
      samples { [association(:sample)] }
    end

    factory :data_type_with_devices do
      devices { [association(:devices)] }
    end

  end
end