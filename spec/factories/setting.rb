# frozen_string_literal: true

FactoryBot.define do
  factory :setting do
    var { "Setting Var" }
    value { "Setting Value" }
  end
end