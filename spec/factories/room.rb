# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name { "Room Name" }
    room_type { 'box' }
    length { 10 }
    width { 10 }
    height { 10 }
  end
end