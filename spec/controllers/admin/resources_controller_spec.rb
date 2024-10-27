# frozen_string_literal: true

# spec/controllers/admin/resources_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::ResourcesController, type: :controller do
  let(:resource) { create(:resource) }
  let(:valid_attributes) { resource.attributes }
  let(:invalid_attributes) { attributes_for(:resource, name: nil) }
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'filters resources by category_id' do
      get :index, params: { category_id: resource.category_id }
      expect(assigns(:resources)).to include(resource)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: resource.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: resource.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Resource' do
        resource
        expect do
          post :create, params: { resource: valid_attributes }
        end.to change(Resource, :count).by(1)
      end

      it 'redirects to the resources list' do
        resource
        post :create, params: { resource: valid_attributes }
        expect(response).to redirect_to(admin_resources_url)
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        resource
        post :create, params: { resource: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Updated Resource Name'
        }
      end

      it 'updates the requested resource' do
        put :update, params: { id: resource.to_param, resource: new_attributes }
        resource.reload
        expect(resource.name).to eq('Updated Resource Name')
      end

      it 'redirects to the resources list' do
        put :update, params: { id: resource.to_param, resource: valid_attributes }
        expect(response).to redirect_to(admin_resources_url)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        put :update, params: { id: resource.to_param, resource: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested resource' do
      resource
      expect do
        delete :destroy, params: { id: resource.to_param }
      end.to change(Resource, :count).by(-1)
    end

    it 'redirects to the resources list' do
      resource
      delete :destroy, params: { id: resource.to_param }
      expect(response).to redirect_to(admin_resources_url)
    end
  end
end