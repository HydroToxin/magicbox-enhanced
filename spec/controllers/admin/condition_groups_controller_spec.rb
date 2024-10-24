# spec/controllers/admin/condition_groups_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::ConditionGroupsController, type: :controller do
  let(:scenario) { create(:scenario) }
  let(:condition_group) { create(:condition_group, scenario: scenario) }

  before do
    # Assuming you have authentication in place
    sign_in create(:user, admin: true)
  end

  describe 'GET #new' do
    it 'returns a success response for HTML format' do
      get :new, format: :html
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:condition_group) }

      it 'creates a new ConditionGroup' do
        expect {
          post :create, params: { scenario_id: scenario.id, condition_group: valid_attributes }, format: :turbo_stream
        }.to change(ConditionGroup, :count).by(1)
      end

      it 'redirects to the scenario path on HTML format' do
        post :create, params: { scenario_id: scenario.id, condition_group: valid_attributes }, format: :html
        expect(response).to redirect_to(admin_scenario_path(scenario))
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { scenario_id: scenario.id, condition_group: { name: nil } }, format: :html
        expect(response).to render_template('new')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested condition group' do
      condition_group # Ensure the condition group is created before trying to delete it
      expect {
        delete :destroy, params: { id: condition_group.to_param }, format: :turbo_stream
      }.to change(ConditionGroup, :count).by(-1)
    end

    it 'redirects to the scenario path on HTML format' do
      delete :destroy, params: { id: condition_group.to_param }, format: :html
      expect(response).to redirect_to(admin_scenario_path(condition_group.scenario))
    end
  end
end