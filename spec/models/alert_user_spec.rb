# frozen_string_literal: true

# spec/models/alert_user_spec.rb

require 'rails_helper'

RSpec.describe AlertUser, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:alert) }
    it { is_expected.to belong_to(:user).class_name('User').with_foreign_key(:user_id) }
  end
end