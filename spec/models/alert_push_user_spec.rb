# frozen_string_literal: true

# spec/models/alert_push_user_spec.rb

require 'rails_helper'

RSpec.describe AlertPushUser, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:alert) }
    it { is_expected.to belong_to(:user) }
  end
end