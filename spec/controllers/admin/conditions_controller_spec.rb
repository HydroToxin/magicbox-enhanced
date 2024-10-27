# spec/controllers/admin/conditions_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::ConditionsController, type: :controller do
  let(:condition) { create(:condition) }
  let(:condition_group) { create(:condition_group) }
  let(:data_type) { create(:data_type) }

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
      let(:valid_attributes) {
        attributes_for(
          :condition,
          condition_group_id: condition_group.id,
          data_type_id: data_type.id
        )
      }

      it 'creates a new Condition' do
        expect {
          post :create, params: { condition: valid_attributes }
        }.to change(Condition, :count).by(1)
      end

      it 'redirects to the conditions list on HTML format' do
        post :create, params: { condition: valid_attributes }
        expect(response).to redirect_to(admin_conditions_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:condition, data_type: nil) }
      it 'renders the new template' do
        post :create, params: { condition: invalid_attributes }
        expect(response).to render_template('new')
      end
    end

  end

  describe 'DELETE #destroy' do
    it 'destroys the requested condition' do
      condition
      expect {
        delete :destroy, params: { id: condition.to_param }
      }.to change(Condition, :count).by(-1)
    end

    it 'redirects to the conditions list on HTML format' do
      delete :destroy, params: { id: condition.to_param }
      expect(response).to redirect_to admin_conditions_path
    end
  end
end