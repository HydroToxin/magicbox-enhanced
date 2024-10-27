# frozen_string_literal: true

# spec/controllers/batches_controller_spec.rb

require 'rails_helper'

RSpec.describe BatchesController, type: :controller do
  let(:batch) { create(:batch) }
  let(:valid_attributes) { attributes_for(:batch)}
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all batches as @batches' do
      batch
      get :index
      expect(assigns(:batches)).to eq([batch])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: batch.to_param }
      expect(response).to be_successful
    end

    it 'assigns the requested batch as @batch' do
      get :show, params: { id: batch.to_param }
      expect(assigns(:batch)).to eq(batch)
    end
  end
end