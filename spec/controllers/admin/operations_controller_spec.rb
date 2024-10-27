# frozen_string_literal: true

# spec/controllers/admin/operations_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::OperationsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:operation) { create(:operation) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: operation.to_param }
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
      get :edit, params: { id: operation.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:operation, condition_group_id: operation.condition_group_id) }

      it 'creates a new Operation' do
        operation
        expect {
          post :create, params: { operation: valid_attributes }
        }.to change(Operation, :count).by(1)
      end

      it 'redirects to the created operation' do
        post :create, params: { operation: valid_attributes }
        expect(response).to redirect_to(admin_operations_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:operation, command: nil) }

      it 'does not create a new Operation' do
        expect {
          post :create, params: { operation: invalid_attributes }
        }.not_to change(Operation, :count)
      end

      it 'renders the new template' do
        post :create, params: { operation: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { command: 'New Command' } }

      it 'updates the requested operation' do
        patch :update, params: { id: operation.to_param, operation: new_attributes }
        operation.reload
        expect(operation.command).to eq('New Command')
      end

      it 'redirects to the operation' do
        patch :update, params: { id: operation.to_param, operation: new_attributes }
        expect(response).to redirect_to(admin_operations_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { command: nil } }

      it 'does not update the operation' do
        patch :update, params: { id: operation.to_param, operation: invalid_attributes }
        operation.reload
        expect(operation.command).not_to be_nil
      end

      it 'renders the edit template' do
        patch :update, params: { id: operation.to_param, operation: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested operation' do
      operation_to_delete = create(:operation)
      expect {
        delete :destroy, params: { id: operation_to_delete.to_param }
      }.to change(Operation, :count).by(-1)
    end

    it 'redirects to the operations list' do
      delete :destroy, params: { id: operation.to_param }
      expect(response).to redirect_to(admin_operations_path)
    end
  end
end