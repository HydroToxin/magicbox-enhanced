# frozen_string_literal: true

# spec/models/push_device_spec.rb

require 'rails_helper'

RSpec.describe PushDevice, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end