# frozen_string_literal: true

# spec/controllers/admin/users_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, admin: true) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      get :edit, params: { id: user.to_param }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:user) }

      it 'creates a new User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the users list' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:user, email: nil) }

      it 'does not create a new User' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { username: 'UpdatedUsername' } }

      it 'updates the requested user' do
        put :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.username).to eq('UpdatedUsername')
      end

      it 'redirects to the users list' do
        put :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { email: nil } }

      it 'does not update the user' do
        put :update, params: { id: user.to_param, user: invalid_attributes }
        user.reload
        expect(user.email).not_to be_nil
      end

      it 'renders the edit template' do
        put :update, params: { id: user.to_param, user: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user # Ensure the user is created
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to(admin_users_url)
    end
  end
end