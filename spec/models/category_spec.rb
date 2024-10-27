# frozen_string_literal: true

# spec/models/category_spec.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:resources) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end