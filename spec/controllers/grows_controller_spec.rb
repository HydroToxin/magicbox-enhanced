# frozen_string_literal: true

# spec/controllers/grows_controller_spec.rb

require 'rails_helper'

RSpec.describe GrowsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:grow) { create(:grow) }

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns @grows and renders the index template' do
      get :index
      expect(assigns(:grows)).to eq([grow])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested grow to @grow and renders the show template' do
      get :show, params: { id: grow.id }
      expect(assigns(:grow)).to eq(grow)
      expect(response).to render_template(:show)
    end

    it 'responds with JSON format including subjects' do
      get :show, params: { id: grow.id }, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(grow.id)
      expect(json_response).to have_key('subjects')
    end
  end

  describe 'GET #print_qr' do
    it 'renders the print_qr template' do
      get :print_qr, params: { id: grow.id }
      expect(response).to render_template(:print_qr)
    end
  end
end