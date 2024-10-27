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
    it { is_expected.to have_many(:resource_datas).class_name('ResourceData') }
    it { is_expected.to have_many(:subjects).through(:observations_subjects).dependent(:destroy) }
    it { is_expected.to have_many(:issues) }
    it { is_expected.to have_many_attached(:pictures) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:resource_datas).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:issues).allow_destroy(true) }

    context 'when resource_data value is blank' do
      let(:observation) { build(:observation) }

      it 'rejects the nested attributes' do
        observation.resource_datas_attributes = [{ value: '' }]
        expect(observation.resource_datas).to be_empty
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

  describe '#pictures_url' do
    let(:observation) { create(:observation) }

    # Ensure the sample.jpg file exists in the specified path
    let(:picture) { fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.jpg'), 'image/jpeg') }

    before do
      observation.pictures.attach(picture)
      ActiveStorage::Current.host = 'http://example.com'
    end

    it 'returns an array of URLs for the attached pictures' do
      expect(observation.pictures_url).to all(match(%r{http://example.com/rails/active_storage/blobs/.+}))
    end
  end

  describe '#url' do
    let(:observation) { create(:observation) }

    it 'returns the URL for the grow observation path' do
      expect(observation.url).to eq(Rails.application.routes.url_helpers.grow_observation_path(observation.grow, observation))
    end
  end
end