# frozen_string_literal: true

# spec/models/room_scenario_spec.rb

require 'rails_helper'

RSpec.describe RoomScenario, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:room) }
    it { is_expected.to belong_to(:scenario) }
  end
end