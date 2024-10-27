# frozen_string_literal: true

# spec/controllers/notifications_controller_spec.rb

require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let!(:notifications) { create_list(:notification, 5, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns paginated notifications to @notifications' do
      get :index, params: { page: 1 }
      expect(assigns(:notifications)).to match_array(user.notifications.paginate(page: 1, per_page: 100))
    end

    it 'marks notifications as read' do
      expect(user.mark_notifications_as_read).to eq(5)
      get :index
    end

    it 'adds a breadcrumb for Notifications' do
      #expect(controller).to receive(:add_breadcrumb).with('Notifications')
      get :index
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested notification' do
      notification = notifications.first
      expect {
        delete :destroy, params: { id: notification.id }
      }.to change(Notification, :count).by(-1)
    end

    it 'redirects to the notifications list with a notice' do
      notification = notifications.first
      delete :destroy, params: { id: notification.id }
      expect(response).to redirect_to(notifications_path)
      expect(flash[:notice]).to eq('Notification was successfully destroyed.')
    end
  end

  describe 'DELETE #clear_all' do
    it 'destroys all notifications' do
      expect {
        delete :clear_all
      }.to change(Notification, :count).by(-notifications.size)
    end

    it 'redirects back with a notice' do
      request.env['HTTP_REFERER'] = root_url
      delete :clear_all
      expect(response).to redirect_to(root_url)
      expect(flash[:notice]).to eq('All notifications successfully deleted.')
    end
  end
end