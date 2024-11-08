# frozen_string_literal: true

# spec/controllers/admin/observation_resources_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::ObservationResourcesController, type: :controller do
  let(:observation_resource) { create(:observation_resource) }
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested observation_resource' do
      observation_resource_to_delete = create(:observation_resource)
      expect do
        delete :destroy, params: { id: observation_resource_to_delete.to_param }
      end.to change(ObservationResource, :count).by(-1)
    end

    it 'redirects to the observation_resources list' do
      delete :destroy, params: { id: observation_resource.to_param }
      expect(response).to redirect_to(admin_observation_resources_url)
    end

    it 'responds with no content for turbo stream format' do
      delete :destroy, params: { id: observation_resource.to_param }, format: :turbo_stream
      expect(response).to have_http_status(:no_content)
    end
  end
end
