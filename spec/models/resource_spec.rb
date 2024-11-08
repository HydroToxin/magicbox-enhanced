# frozen_string_literal: true

# spec/models/resource_spec.rb

require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:observation_resources) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:shortname) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:choices) }
    it { is_expected.to validate_presence_of(:units) }
  end
end
