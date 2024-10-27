# spec/controllers/admin/condition_groups_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::ConditionGroupsController, type: :controller do

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
      let(:valid_attributes) { attributes_for(:condition_group, name: 'test', scenario_id: create(:scenario).id) }

      it 'creates a new ConditionGroup' do
        expect {
          post :create, params: { condition_group: valid_attributes }
        }.to change(ConditionGroup, :count).by(1)
      end

      it 'redirects to the condition_groups list on HTML format' do
        post :create, params: { condition_group: valid_attributes }
        expect(response).to redirect_to(admin_condition_groups_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:condition_group, data_type: nil) }
      it 'renders the new template' do
        post :create, params: { condition_group: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @condition_group = create(:condition_group)
    end

    it 'destroys the requested condition group' do
      expect {
        delete :destroy, params: { id: @condition_group.to_param }, format: :turbo_stream
      }.to change(ConditionGroup, :count).by(-1)
    end

    it 'redirects to the contions list on HTML format' do
      delete :destroy, params: { id: @condition_group.to_param }, format: :html
      expect(response).to redirect_to admin_condition_groups_path
    end
  end
end