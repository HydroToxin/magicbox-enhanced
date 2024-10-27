# frozen_string_literal: true

# spec/controllers/admin/grows_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::GrowsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:grow) { create(:grow) }
  let(:valid_attributes) { attributes_for(:grow) }
  let(:invalid_attributes) { { birth_type: nil } }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new grow as @grow' do
      get :new
      expect(assigns(:grow)).to be_a_new(Grow)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested grow as @grow' do
      get :edit, params: { id: grow.to_param }
      expect(assigns(:grow)).to eq(grow)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Grow' do
        expect {
          post :create, params: { grow: valid_attributes }
        }.to change(Grow, :count).by(1)
      end

      it 'redirects to the created grow' do
        post :create, params: { grow: valid_attributes }
        expect(response).to redirect_to(Grow.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Grow' do
        expect {
          post :create, params: { grow: invalid_attributes }
        }.not_to change(Grow, :count)
      end

      it 'renders the new template' do
        post :create, params: { grow: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { description: 'Updated description' } }

      it 'updates the requested grow' do
        patch :update, params: { id: grow.to_param, grow: new_attributes }
        grow.reload
        expect(grow.description).to eq('Updated description')
      end

      it 'redirects to the grow' do
        patch :update, params: { id: grow.to_param, grow: valid_attributes }
        expect(response).to redirect_to(grow)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update, params: { id: grow.to_param, grow: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested grow' do
      grow = create(:grow)
      expect {
        delete :destroy, params: { id: grow.to_param }
      }.to change(Grow, :count).by(-1)
    end

    it 'redirects to the grows list' do
      delete :destroy, params: { id: grow.to_param }
      expect(response).to redirect_to(grows_url)
    end
  end
end