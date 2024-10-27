# frozen_string_literal: true

# spec/controllers/admin/resource_datas_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::ResourceDatasController, type: :controller do
  let(:resource_data) { create(:resource_data) }
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'DELETE #destroy' do

    it 'destroys the requested resource_data' do
      resource_data_to_delete = create(:resource_data)
      expect {
        delete :destroy, params: { id: resource_data_to_delete.to_param }
      }.to change(ResourceData, :count).by(-1)
    end

    it 'redirects to the resource_datas list' do
      delete :destroy, params: { id: resource_data.to_param }
      expect(response).to redirect_to(admin_resource_datas_url)
    end

    it 'responds with no content for turbo stream format' do
      delete :destroy, params: { id: resource_data.to_param }, format: :turbo_stream
      expect(response).to have_http_status(:no_content)
    end
  end
end
