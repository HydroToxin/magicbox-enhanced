# frozen_string_literal: true

# spec/models/grow_spec.rb

require 'rails_helper'

RSpec.describe Grow, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:subjects).dependent(:delete_all) }
    it { is_expected.to have_many(:weeks).dependent(:delete_all) }
    it { is_expected.to have_many(:observations).dependent(:delete_all) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
    it { is_expected.to have_one(:harvest) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:birth_type) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:grow_status) }

    context 'when birth_type is from_clone' do
      let(:grow) { build(:grow, birth_type: 'from_clone') }

      it 'validates presence of number_of_subjects' do
        grow.number_of_subjects = nil
        grow.validate
        expect(grow.errors[:number_of_subjects]).to include("can't be blank when birth type is 'from clone'.")
      end
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:grow_status).with_values(%i[scheduled seedling vegging flowering flushing drying curing done aborted]) }
    it { is_expected.to define_enum_for(:substrate).with_values(%i[soil coco hydro aero]) }
    it { is_expected.to define_enum_for(:flowering).with_values(%i[photoperiodic autoflowering]) }
  end

  describe '#name' do
    let(:grow) { build(:grow, id: 1, description: 'Test Description') }

    it 'returns formatted name' do
      expect(grow.name).to eq('#1 - Test Description')
    end
  end

  describe '#harvestable?' do
    it 'returns true if grow status is drying, curing, or done' do
      %w[drying curing done].each do |status|
        grow = build(:grow, grow_status: status)
        expect(grow.harvestable?).to be(true)
      end
    end

    it 'returns false for other statuses' do
      %w[scheduled seedling vegging flowering flushing aborted].each do |status|
        grow = build(:grow, grow_status: status)
        expect(grow.harvestable?).to be(false)
      end
    end
  end

  describe '#active_subjects' do
    let(:grow) { create(:grow) }
    let!(:active_subject) { create(:subject, grow:) }
    let!(:inactive_subject) { create(:subject, grow: create(:grow, grow_status: 'done')) }

    it 'returns only active subjects' do
      expect(grow.active_subjects).to include(active_subject)
      expect(grow.active_subjects).not_to include(inactive_subject)
    end
  end

  describe '#nb_weeks' do
    let(:grow) { create(:grow, start_date: Date.today, end_date: Date.today + 21.days) }

    it 'calculates the number of weeks between start and end date' do
      grow.generate_weeks
      expect(grow.nb_weeks).to eq(3)
    end
  end

  describe '#status_badge_class' do
    it 'returns correct badge class based on grow status' do
      {
        'done' => 'badge-light border',
        'aborted' => 'badge-danger',
        'seedling' => 'badge-success',
        'vegging' => 'badge-success',
        'flowering' => 'badge-success',
        'flushing' => 'badge-info',
        'drying' => 'badge-warning',
        'curing' => 'badge-warning'
      }.each do |status, expected_class|
        grow = build(:grow, grow_status: status)
        expect(grow.status_badge_class).to eq(expected_class)
      end
    end
  end

  describe '.active_grows' do
    let!(:active_grow) { create(:grow, grow_status: 'seedling') }
    let!(:inactive_grow) { create(:grow, grow_status: 'done') }

    it 'returns grows that are not done or aborted' do
      expect(Grow.active_grows).to include(active_grow)
      expect(Grow.active_grows).not_to include(inactive_grow)
    end
  end

  describe '.inactive_grows' do
    let!(:active_grow) { create(:grow, grow_status: 'seedling') }
    let!(:inactive_grow) { create(:grow, grow_status: 'done') }

    it 'returns grows that are done or aborted' do
      expect(Grow.inactive_grows).to include(inactive_grow)
      expect(Grow.inactive_grows).not_to include(active_grow)
    end
  end

  # Additional tests can be added for methods like `generate_weeks`, `current_week`, etc.
end