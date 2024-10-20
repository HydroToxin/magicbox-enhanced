# frozen_string_literal: true

class RoomScenario < ApplicationRecord
  belongs_to :room
  belongs_to :scenario
end
