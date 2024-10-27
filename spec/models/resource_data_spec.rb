# frozen_string_literal: true

# spec/models/resource_data_spec.rb

require 'rails_helper'

RSpec.describe ResourceData, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:resource) }
    it { is_expected.to belong_to(:observation) }
    # Uncomment the line below if the subject association is needed in the future
    # it { is_expected.to belong_to(:subject) }
  end

  describe 'attributes' do
    it 'has a category_id attribute' do
      resource_data = described_class.new
      expect(resource_data).to respond_to(:category_id)
    end
  end
end