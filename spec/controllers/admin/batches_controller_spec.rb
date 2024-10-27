# spec/controllers/admin/batches_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::BatchesController, type: :controller do
  let(:grow) { create(:grow) }
  let(:harvest) { create(:harvest) }
  let(:batch) { create(:batch, grow: grow, harvest: harvest) }
  let(:admin_user) { create(:user, admin: true) }

  before do
    # Assuming you have authentication in place
    sign_in admin_user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: batch.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:batch, grow_id: grow.id, harvest_id: harvest.id) }

      it 'creates a new Batch' do
        expect {
          post :create, params: { batch: valid_attributes }
        }.to change(Batch, :count).by(1)
      end

      it 'redirects to the created batch' do
        post :create, params:  { batch: valid_attributes }
        expect(response).to redirect_to([grow, harvest])
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:alert, grow_id: grow.id, harvest_id: nil) }
      it 'renders the new template' do
        post :create, params: { batch: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Batch Name' } }

      it 'updates the requested batch' do
        put :update, params: { id: batch.to_param, batch: new_attributes }
        batch.reload
        expect(batch.name).to eq('Updated Batch Name')
      end

      it 'redirects to the batch' do
        put :update, params: { id: batch.to_param, batch: new_attributes }
        expect(response).to redirect_to([grow, harvest])
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { harvest_id: nil } }

      it 'renders the edit template' do
        put :update, params: { id: batch.to_param, batch: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested batch' do
      batch
      expect {
        delete :destroy, params: { id: batch.to_param }
      }.to change(Batch, :count).by(-1)
    end

    it 'redirects to the batches list' do
      delete :destroy, params: { id: batch.to_param }
      expect(response).to redirect_to([grow, harvest])
    end
  end
end