# frozen_string_literal: true

# spec/controllers/admin/harvests_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::HarvestsController, type: :controller do
  let(:grow) { create(:grow) }
  let(:harvest) { create(:harvest, grow: grow) }
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  before do
    allow(controller).to receive(:set_grow).and_return(grow)
  end

  describe 'GET #new' do
    it 'assigns a new harvest as @harvest' do
      get :new, params: { grow_id: grow.id }
      expect(assigns(:harvest)).to be_a_new(Harvest)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested harvest as @harvest' do
      get :edit, params: { id: harvest.to_param, grow_id: grow.id }
      expect(assigns(:harvest)).to eq(harvest)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:harvest, grow_id: grow.id) }

      it 'creates a new Harvest' do
        grow
        expect {
          post :create, params: { harvest: valid_attributes, grow_id: grow.id }
        }.to change(Harvest, :count).by(1)
      end

      it 'assigns a newly created harvest as @harvest' do
        post :create, params: { harvest: valid_attributes, grow_id: grow.id }
        expect(assigns(:harvest)).to be_a(Harvest)
        expect(assigns(:harvest)).to be_persisted
      end

      it 'redirects to the created harvest' do
        post :create, params: { harvest: valid_attributes, grow_id: grow.id }
        expect(response).to redirect_to(admin_grow_harvests_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:harvest, grow_id: nil) }

      it 'assigns a newly created but unsaved harvest as @harvest' do
        post :create, params: { harvest: invalid_attributes, grow_id: grow.id }
        expect(assigns(:harvest)).to be_a_new(Harvest)
      end

      it 're-renders the "new" template' do
        post :create, params: { harvest: invalid_attributes, grow_id: grow.id }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { harvested_bud_weight: 100 } }

      it 'updates the requested harvest' do
        put :update, params: { id: harvest.to_param, harvest: new_attributes, grow_id: grow.id }
        harvest.reload
        expect(harvest.harvested_bud_weight).to eq(100)
      end

      it 'assigns the requested harvest as @harvest' do
        put :update, params: { id: harvest.to_param, harvest: new_attributes, grow_id: grow.id }
        expect(assigns(:harvest)).to eq(harvest)
      end

      it 'redirects to the harvest' do
        put :update, params: { id: harvest.to_param, harvest: new_attributes, grow_id: grow.id }
        expect(response).to redirect_to(admin_grow_harvests_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { harvested_bud_weight: nil } }

      it 'assigns the harvest as @harvest' do
        put :update, params: { id: harvest.to_param, harvest: invalid_attributes, grow_id: grow.id }
        expect(assigns(:harvest)).to eq(harvest)
      end

      it 're-renders the "edit" template' do
        put :update, params: { id: harvest.to_param, harvest: invalid_attributes, grow_id: grow.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested harvest' do
      harvest.save
      expect {
        delete :destroy, params: { id: harvest.to_param, grow_id: grow.id }
      }.to change(Harvest, :count).by(-1)
    end

    it 'redirects to the grow' do
      delete :destroy, params: { id: harvest.to_param, grow_id: grow.id }
      expect(response).to redirect_to(grow)
    end
  end
end