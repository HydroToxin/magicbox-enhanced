# frozen_string_literal: true

# spec/models/sample_spec.rb

require 'rails_helper'

RSpec.describe Sample, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:device).optional }
    it { is_expected.to belong_to(:data_type) }
  end

  describe 'default scope' do
    let!(:sample1) { create(:sample, created_at: 1.day.ago) }
    let!(:sample2) { create(:sample, created_at: 2.days.ago) }
    let!(:sample3) { create(:sample, created_at: Time.current) }

    it 'orders by created_at in descending order' do
      expect(Sample.all).to eq([sample3, sample1, sample2])
    end
  end
end