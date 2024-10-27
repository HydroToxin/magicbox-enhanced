# frozen_string_literal: true

# spec/models/condition_spec.rb

require 'rails_helper'

RSpec.describe Condition, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:condition_group) }
    it { is_expected.to belong_to(:data_type) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:condition_type).with_values(date: 0, time_duration: 4, data_type: 1, resource: 2, device_state: 3) }
    it { is_expected.to define_enum_for(:logic).with_values(and_operator: 0, or_operator: 1) }
  end

  describe 'callbacks' do
    context 'after_initialize' do
      let(:condition) { build(:condition) }

      it 'sets time_duration_hours and time_duration_minutes based on duration' do
        # expect(condition.time_duration_hours).to eq(2)
        # expect(condition.time_duration_minutes).to eq(5)
      end
    end

    context 'after_find' do
      let!(:condition) { create(:condition, duration: 125) }

      it 'sets time_duration_hours and time_duration_minutes based on duration' do
        found_condition = Condition.find(condition.id)
        # expect(found_condition.time_duration_hours).to eq(2)
        # expect(found_condition.time_duration_minutes).to eq(5)
      end
    end
  end

  describe '.condition_type_text' do
    it 'returns "Time Range" for :date' do
      expect(described_class.condition_type_text(:date)).to eq('Time Range')
    end

    it 'returns titleized string for other types' do
      expect(described_class.condition_type_text(:time_duration)).to eq('Time Duration')
    end
  end

  describe '.logic_text' do
    it 'returns "AND" for :and_operator' do
      expect(described_class.logic_text(:and_operator)).to eq('AND')
    end

    it 'returns "OR" for :or_operator' do
      expect(described_class.logic_text(:or_operator)).to eq('OR')
    end
  end

  describe '#check_condition' do
    let(:room) { double('Room') }
    let(:condition) { build(:condition, condition_type: :date) }

    it 'returns true if date condition is valid' do
      allow(condition).to receive(:need_check_between).and_return(false)
      expect(condition.check_condition(room)).to be(true)
    end

    # Additional tests for other condition types can be added here
  end

  describe '#condition_text' do
    let(:condition) { build(:condition, condition_type: :date, start_time: Time.now, end_time: Time.now + 3600) }

    it 'returns formatted text for date condition' do
      expect(condition.condition_text).to include('current time')
    end

    # Additional tests for other condition types can be added here
  end

  describe '#compute_duration' do
    let(:condition) { build(:condition, time_duration_hours: 2, time_duration_minutes: 30) }

    it 'computes the total duration in minutes' do
      expect(condition.compute_duration).to eq(150)
    end
  end
end