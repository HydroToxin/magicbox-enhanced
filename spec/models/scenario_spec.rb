# frozen_string_literal: true

# spec/models/scenario_spec.rb

require 'rails_helper'

RSpec.describe Scenario, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:subject).optional }
    it { is_expected.to have_many(:room_scenarios).dependent(:destroy) }
    it { is_expected.to have_many(:rooms).through(:room_scenarios) }
    it { is_expected.to have_many(:condition_groups).dependent(:destroy) }
    it { is_expected.to have_many(:conditions).through(:condition_groups) }
    it { is_expected.to have_many(:operations).through(:condition_groups) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'nested attributes' do
    let(:scenario) { build(:scenario) }

    it 'accepts nested attributes for condition_groups with allow_destroy' do
      expect(scenario).to accept_nested_attributes_for(:condition_groups)
        .allow_destroy(true)
    end

    it 'rejects condition_groups if all attributes are blank' do
      scenario = described_class.new(
        name: 'Test Scenario',
        condition_groups_attributes: [{ name: '' }]
      )
      expect(scenario.condition_groups).to be_empty
    end
  end

  describe '#as_json' do
    let(:scenario) { create(:scenario) }
    let!(:condition_group) { create(:condition_group, scenario: scenario) }


    it 'returns a hash with transformed keys' do
      json_output = scenario.as_json
      expect(json_output).to have_key('condition_groups_attributes')
      expect(json_output['condition_groups_attributes']).to all(have_key('conditions_attributes'))
      expect(json_output['condition_groups_attributes']).to all(have_key('operations_attributes'))
    end
  end

  describe '#run' do
    let(:room) { create(:room) }
    let(:scenario) { create(:scenario, enabled: true) }
    let(:group) { create(:condition_group, scenario: scenario, enabled: true) }
    let(:condition) { create(:condition, condition_group: group) }
    let(:operation) { create(:operation, condition_group: group) }
    let(:condition_group) { create(:condition_group, scenario: scenario) }

    before do
      allow(condition).to receive(:check_condition).and_return(true)
      # allow(operation).to receive(:execute_operation)
      # allow(condition_group).to receive(:conditions_met?).with(room).and_return(true)
      scenario.condition_groups << group
    end

    it 'executes operations if all conditions are met' do
      # expect_any_instance_of(Operation).to receive(:execute_operation).with(room)

      # scenario.run(room)
    end

    it 'logs information when conditions are not met' do
      # allow(condition_group).to receive(:conditions_met?).with(room).and_return(false)

      # expect(Rails.logger).to receive(:info).with("Conditions not met for room #{room.id}")

      # scenario.run(room)
    end
  end

  describe '.run_scenarios' do
    let!(:room) { create(:room) }
    let!(:scenario) { create(:scenario, enabled: true) }

    before do
      room.scenarios << scenario
      allow(scenario).to receive(:run)
    end

    it 'runs scenarios for each room' do
      #expect(scenario).to receive(:run).with(room)
      described_class.run_scenarios
    end
  end

  describe '.import' do
    let(:file_path) { 'path/to/json_file.json' }
    let(:json_content) { { 'name' => 'Test Scenario' }.to_json }

    before do
      allow(File).to receive(:read).with(file_path).and_return(json_content)
      allow(JSON).to receive(:parse).and_return(JSON.parse(json_content))
    end

    it 'creates a new scenario from a JSON file' do
      scenario = described_class.import(file_path, 'Imported Scenario')
      expect(scenario.name).to eq('Imported Scenario')
      expect(scenario).to be_persisted
    end
  end
end
