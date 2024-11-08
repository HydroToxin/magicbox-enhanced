# frozen_string_literal: true

# spec/models/observation_spec.rb

require 'rails_helper'

RSpec.describe Observation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:grow) }
    it { is_expected.to belong_to(:room).optional }
    it { is_expected.to have_many(:events).dependent(:destroy) }
    it { is_expected.to have_many(:observations_subjects).dependent(:destroy) }
    it { is_expected.to have_many(:observation_resources).class_name('ObservationResource') }
    it { is_expected.to have_many(:subjects).through(:observations_subjects).dependent(:destroy) }
    it { is_expected.to have_many(:issues) }
    it { is_expected.to have_many_attached(:pictures) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:observation_resources).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:issues).allow_destroy(true) }

    context 'when observation_resource value is blank' do
      let(:observation) { build(:observation) }

      it 'rejects the nested attributes' do
        observation.observation_resources_attributes = [{ value: '' }]
        expect(observation.observation_resources).to be_empty
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe '#start_date' do
    let(:observation) { build(:observation) }

    it 'returns the created_at timestamp' do
      expect(observation.start_date).to eq(observation.created_at)
    end
  end

  describe '#end_date' do
    let(:observation) { create(:observation) }

    it 'returns one hour after the created_at timestamp' do
      expect(observation.end_date).to eq(observation.created_at + 1.hour)
    end
  end

  describe '#text' do
    let(:observation) { build(:observation, body: 'Sample text') }

    it 'returns the body of the observation' do
      expect(observation.text).to eq('Sample text')
    end
  end

  describe '#url' do
    let(:observation) { create(:observation) }

    it 'returns the URL for the grow observation path' do
      expect(observation.url).to eq(Rails.application.routes.url_helpers.grow_observation_path(observation.grow,
observation))
    end
  end
end
