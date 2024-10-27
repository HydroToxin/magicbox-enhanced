# frozen_string_literal: true

# spec/controllers/dashboard_controller_spec.rb

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #index' do
    context 'when user is authenticated' do
      let(:user) { create(:user) }
      let!(:grows) { create_list(:grow, 3, grow_status: :scheduled) }
      let!(:todos) { create_list(:todo, 5, user: user, todo_status: :todo) }

      before do
        sign_in user
        get :index
      end

      it 'assigns @grows with grows not done or aborted' do
        expect(assigns(:grows)).to match_array(grows)
      end

      it 'assigns @todos with the current user\'s todos limited to 10' do
        expect(assigns(:todos)).to match_array(todos)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not authenticated' do
      before { get :index }

      it 'redirects to the login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end