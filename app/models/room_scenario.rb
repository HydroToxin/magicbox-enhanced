# frozen_string_literal: true

# RoomScenario
class RoomScenario < ApplicationRecord
  belongs_to :room
  belongs_to :scenario
end
