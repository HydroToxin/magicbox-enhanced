# frozen_string_literal: true

# spec/controllers/observations_controller_spec.rb

require 'rails_helper'

RSpec.describe ObservationsController, type: :controller do
  let(:user) { create(:user) }
  let!(:observation) { create(:observation) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all observations to @observations' do
      get :index, params: { grow_id: observation.grow.id }
      expect(assigns(:observations)).to eq([observation])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested observation to @observation' do
      get :show, params: { id: observation.id, grow_id: observation.grow.id }
      expect(assigns(:observation)).to eq(observation)
    end
  end

  describe 'GET #new' do
    it 'assigns a new observation to @observation' do
      get :new, params: { grow_id: observation.grow.id }
      expect(assigns(:observation)).to be_a_new(Observation)
    end

    it 'adds a breadcrumb for New observation' do
      #expect(controller).to receive(:add_breadcrumb).with('New observation')
      get :new, params: { grow_id: observation.grow.id }
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested observation to @observation' do
      get :edit, params: { id: observation.id, grow_id: observation.grow.id }
      expect(assigns(:observation)).to eq(observation)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { observation.attributes }

      it 'creates a new Observation' do
        expect {
          post :create, params: { observation: valid_attributes}
        }.to change(Observation, :count).by(1)
      end

      it 'redirects to the created observation' do
        post :create, params: { observation: valid_attributes }
        expect(response).to redirect_to(observation.grow)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:observation, body: nil) }

      it 'does not create a new Observation' do
        expect {
          post :create, params: { observation: invalid_attributes}
        }.not_to change(Observation, :count)
      end

      it 'renders the new template' do
        post :create, params: { observation: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { body: 'Updated body text' } }

      it 'updates the requested observation' do
        patch :update, params: { id: observation.id, observation: new_attributes }
        observation.reload
        expect(observation.body).to eq('Updated body text')
      end

      it 'redirects to the observation' do
        patch :update, params: { id: observation.id, observation: new_attributes }
        expect(response).to redirect_to([observation.grow, assigns(:observation)])
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { body: nil } }

      it 'does not update the observation' do
        patch :update, params: { id: observation.id, observation: invalid_attributes}
        observation.reload
        expect(observation.body).not_to be_nil
      end

      it 'renders the edit template' do
        patch :update, params: { id: observation.id, observation: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested observation' do
      expect {
        delete :destroy, params: { id: observation.id, grow_id: observation.grow.id }
      }.to change(Observation, :count).by(-1)
    end

    it 'redirects to the grow path' do
      delete :destroy, params: { id: observation.id, grow_id: observation.grow.id }
      expect(response).to redirect_to(observation.grow)
    end
  end
end