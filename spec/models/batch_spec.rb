# frozen_string_literal: true

# spec/models/batch_spec.rb

require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:grow) }
    it { is_expected.to belong_to(:harvest) }
  end

  describe 'enums' do
    it 'defines batch_type enum with expected values' do
      expect(described_class.batch_types).to eq('trim' => 0, 'bud' => 1)
    end
  end

  describe '#total_price' do
    let(:batch) { described_class.new(total_weight: 10, price_per_weight: 5) }

    it 'calculates the total price based on weight and price per weight' do
      expect(batch.total_price).to eq(50)
    end
  end

  # Uncomment and implement these tests when the validations are active
  # describe 'validations' do
  #   it 'validates remaining harvest weight' do
  #     # Add test implementation here
  #   end

  #   it 'validates weight count multiplier' do
  #     # Add test implementation here
  #   end
  # end
end