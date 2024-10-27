# frozen_string_literal: true

# spec/controllers/admin/weeks_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::WeeksController, type: :controller do
  let(:grow) { create(:grow) }
  let(:week) { create(:week, grow: grow) }
  let(:admin_user) { create(:user, admin: true) }

  before do
    sign_in admin_user
  end

  describe 'GET #new' do
    it 'assigns a new week as @week' do
      get :new, params: { grow_id: grow.to_param }
      expect(assigns(:week)).to be_a_new(Week)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested week as @week' do
      get :edit, params: { id: week.to_param, grow_id: grow.to_param }
      expect(assigns(:week)).to eq(week)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:week, grow_id: grow.id) }

      it 'creates a new Week' do
        expect {
          post :create, params: { week: valid_attributes, grow_id: grow.to_param }
        }.to change(Week, :count).by(1)
      end

      it 'redirects to the grow page' do
        post :create, params: { week: valid_attributes, grow_id: grow.to_param }
        expect(response).to redirect_to(admin_grow_path(grow))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:week, week_number: nil) }

      it 'does not create a new Week' do
        expect {
          post :create, params: { week: invalid_attributes, grow_id: grow.to_param }
        }.not_to change(Week, :count)
      end

      it 'renders the new template' do
        post :create, params: { week: invalid_attributes, grow_id: grow.to_param }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { week_number: 2 } }

      it 'updates the requested week' do
        put :update, params: { id: week.to_param, week: new_attributes, grow_id: grow.to_param }
        week.reload
        expect(week.week_number).to eq(2)
      end

      it 'redirects to the grow page' do
        put :update, params: { id: week.to_param, week: new_attributes, grow_id: grow.to_param }
        expect(response).to redirect_to(admin_grow_path(grow))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { week_number: nil } }

      it 'does not update the week' do
        put :update, params: { id: week.to_param, week: invalid_attributes, grow_id: grow.to_param }
        week.reload
        expect(week.week_number).not_to be_nil
      end

      it 'renders the edit template' do
        put :update, params: { id: week.to_param, week: invalid_attributes, grow_id: grow.to_param }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested week' do
      week # Ensure the week is created
      expect {
        delete :destroy, params: { id: week.to_param, grow_id: grow.to_param }
      }.to change(Week, :count).by(-1)
    end

    it 'redirects to the grow page' do
      delete :destroy, params: { id: week.to_param, grow_id: grow.to_param }
      expect(response).to redirect_to(admin_grow_path(grow))
    end
  end
end