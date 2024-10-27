# frozen_string_literal: true

# spec/models/issue_spec.rb

require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:resource) }
    it { is_expected.to belong_to(:subject).optional }
    it { is_expected.to belong_to(:observation) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:severity).with_values(level1: 0, level2: 1, level3: 2) }
    it { is_expected.to define_enum_for(:issue_status).with_values(open: 0, closed: 1) }
    it { is_expected.to define_enum_for(:issue_type).with_values(excess: 0, deficiency: 1) }
  end

  describe '#url' do
    let(:issue) { build(:issue) }

    it 'returns the correct URL path' do
      # Uncomment and adjust the line below when the actual implementation is available
      # expect(issue.url).to eq(Rails.application.routes.url_helpers.grow_path(issue.observation.grow))
    end
  end

  describe '#text' do
    let(:resource) { build(:resource, name: 'ResourceName') }
    let(:issue) { build(:issue, resource:, issue_type: 'excess', severity: 'level1') }

    it 'returns the formatted text' do
      expect(issue.text).to eq('ResourceName excess level1')
    end
  end

  describe '#color' do
    let(:issue) { build(:issue) }

    it 'returns the color coral' do
      expect(issue.color).to eq('coral')
    end
  end

  describe '#start_date' do
    let(:issue) { build(:issue, created_at: Time.zone.now) }

    it 'returns the created_at date' do
      expect(issue.start_date).to eq(issue.created_at)
    end
  end

  describe '#end_date' do
    let(:issue) { build(:issue, created_at: Time.zone.now) }

    it 'returns one hour after the start_date' do
      expect(issue.end_date).to eq(issue.start_date + 1.hour)
    end
  end
end