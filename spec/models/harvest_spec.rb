# frozen_string_literal: true

# spec/models/harvest_spec.rb

require 'rails_helper'

RSpec.describe Harvest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:grow) }
    it { is_expected.to have_many(:batches) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:harvested_trim_weight) }
    it { is_expected.to validate_presence_of(:harvested_waste_weight) }
    it { is_expected.to validate_presence_of(:harvested_bud_weight) }
  end

  describe '#remaining_weight_for_batch_type' do
    let(:harvest) { create(:harvest, dry_trim_weight: 100, dry_bud_weight: 200) }

    context 'when batch_type is trim' do
      before do
        create(:batch, harvest:, batch_type: :trim, total_weight: 30)
      end

      it 'calculates remaining trim weight correctly' do
        expect(harvest.remaining_weight_for_batch_type(:trim)).to eq(70)
      end
    end

    context 'when batch_type is bud' do
      before do
        create(:batch, harvest:, batch_type: :bud, total_weight: 50)
      end

      it 'calculates remaining bud weight correctly' do
        expect(harvest.remaining_weight_for_batch_type(:bud)).to eq(150)
      end
    end

    context 'when batch_type is unknown' do
      it 'returns 0' do
        expect(harvest.remaining_weight_for_batch_type(:unknown)).to eq(0)
      end
    end
  end

  describe '#trim_batched' do
    let(:harvest) { create(:harvest) }

    before do
      create(:batch, harvest:, batch_type: :trim, total_weight: 20)
      create(:batch, harvest:, batch_type: :trim, total_weight: 30)
    end

    it 'sums up all trim batched weights' do
      expect(harvest.trim_batched).to eq(50)
    end
  end

  describe '#bud_batched' do
    let(:harvest) { create(:harvest) }

    before do
      create(:batch, harvest:, batch_type: :bud, total_weight: 40)
      create(:batch, harvest:, batch_type: :bud, total_weight: 60)
    end

    it 'sums up all bud batched weights' do
      expect(harvest.bud_batched).to eq(100)
    end
  end

  describe '#total_trim' do
    let(:harvest) { build(:harvest, harvested_trim_weight: 50, dry_trim_weight: 20) }

    it 'calculates total trim weight' do
      expect(harvest.total_trim).to eq(70)
    end
  end

  describe '#total_waste' do
    let(:harvest) { build(:harvest, harvested_waste_weight: 10) }

    it 'calculates total waste weight' do
      expect(harvest.total_waste).to eq(10)
    end
  end

  describe '#total_bud' do
    let(:harvest) { build(:harvest, harvested_bud_weight: 80, dry_bud_weight: 40) }

    it 'calculates total bud weight' do
      expect(harvest.total_bud).to eq(120)
    end
  end

  describe '#total_wet' do
    let(:harvest) { build(:harvest, harvested_trim_weight: 50, harvested_waste_weight: 10, harvested_bud_weight: 80) }

    it 'calculates total wet weight' do
      expect(harvest.total_wet).to eq(140)
    end
  end

  describe '#total_dry' do
    let(:harvest) { build(:harvest, dry_trim_weight: 20, dry_bud_weight: 40) }

    it 'calculates total dry weight' do
      expect(harvest.total_dry).to eq(60)
    end
  end
end