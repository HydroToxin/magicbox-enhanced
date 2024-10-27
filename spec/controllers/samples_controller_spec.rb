# frozen_string_literal: true

# spec/controllers/samples_controller_spec.rb

require 'rails_helper'

RSpec.describe SamplesController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:sample) { create(:sample) }
  let(:data_type) { create(:data_type) }
  let(:room) { create(:room) }
  let(:harvest) { create(:harvest) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index, params: { sample: { date_filter: 'last_week' } }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #general' do
    it 'assigns @data_types_samples with product references and data types' do
      allow(Sample).to receive_message_chain(:select, :all, :pluck).and_return([sample.product_reference])
      allow(DataType).to receive(:all).and_return([data_type])

      get :general, params: { sample: { date_filter: 'last_week' } }

      expect(assigns(:data_types_samples)).to be_a(Hash)
    end
  end

  describe 'GET #rooms' do
    it 'assigns @data_types_samples with room names and data types' do
      allow(Room).to receive(:all).and_return([room])
      allow(DataType).to receive(:all).and_return([data_type])

      get :rooms, params: { sample: { date_filter: 'last_week' } }

      expect(assigns(:data_types_samples)).to be_a(Hash)
    end
  end

  describe 'GET #harvest' do
    it 'assigns @data_types_samples with harvested data' do
      allow(Harvest).to receive_message_chain(:joins, :order, :group, :sum).and_return({})

      get :harvest, params: { sample: { date_filter: 'last_week' } }

      expect(assigns(:data_types_samples)).to be_an(Array)
    end
  end

  describe 'private methods' do
    describe '#date_filter' do
      it 'sets @date_filter based on sample_params' do
        controller.params = { sample: { date_filter: 'last_week' } }
        controller.send(:date_filter)
        expect(controller.instance_variable_get(:@date_filter)).to eq('last_week')
      end
    end

    describe '#filtered_samples' do
      it 'filters samples based on @date_filter' do
        controller.instance_variable_set(:@date_filter, 'today')
        filtered = controller.send(:filtered_samples, Sample.all)
        expect(filtered).to be_a(ActiveRecord::Relation)
      end
    end
  end
end