# frozen_string_literal: true

# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    context 'when user is authenticated' do
      it 'assigns the requested user to @user' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the show template' do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end

      it 'adds breadcrumbs for profile and email' do
        expect(controller).to receive(:add_breadcrumb).with('Profile')
        expect(controller).to receive(:add_breadcrumb).with(user.email)
        get :show, params: { id: user.id }
      end
    end

    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end