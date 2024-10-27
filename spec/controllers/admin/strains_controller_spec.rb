# frozen_string_literal: true

# spec/controllers/admin/strains_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::StrainsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let!(:strain) { create(:strain) }
  let(:valid_attributes) { attributes_for(:strain)}
  let(:invalid_attributes) { attributes_for(:strain, name: nil) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all strains as @strains' do
      get :index
      expect(assigns(:strains)).to include(strain)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested strain as @strain' do
      get :show, params: { id: strain.to_param }
      expect(assigns(:strain)).to eq(strain)
    end
  end

  describe 'GET #new' do
    it 'assigns a new strain as @strain' do
      get :new
      expect(assigns(:strain)).to be_a_new(Strain)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested strain as @strain' do
      get :edit, params: { id: strain.to_param }
      expect(assigns(:strain)).to eq(strain)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Strain' do
        expect do
          post :create, params: { strain: valid_attributes }
        end.to change(Strain, :count).by(1)
      end

      it 'redirects to the strains list' do
        post :create, params: { strain: valid_attributes }
        expect(response).to redirect_to(admin_strains_url)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Strain' do
        strain
        expect do
          post :create, params: { strain: invalid_attributes }
        end.not_to change(Strain, :count)
      end

      it 'renders the new template' do
        strain
        post :create, params: { strain: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Green Crack' }
      end

      it 'updates the requested strain' do
        put :update, params: { id: strain.to_param, strain: new_attributes }
        strain.reload
        expect(strain.name).to eq('Green Crack')
      end

      it 'redirects to the strains list' do
        put :update, params: { id: strain.to_param, strain: valid_attributes }
        expect(response).to redirect_to(admin_strains_url)
      end
    end

    context 'with invalid params' do
      it 'does not update the strain' do
        put :update, params: { id: strain.to_param, strain: invalid_attributes }
        strain.reload
        expect(strain.name).not_to be_nil
      end

      it 'renders the edit template' do
        put :update, params: { id: strain.to_param, strain: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested strain' do
      expect do
        delete :destroy, params: { id: strain.to_param }
      end.to change(Strain, :count).by(-1)
    end

    it 'redirects to the strains list' do
      delete :destroy, params: { id: strain.to_param }
      expect(response).to redirect_to(admin_strains_url)
    end
  end
end