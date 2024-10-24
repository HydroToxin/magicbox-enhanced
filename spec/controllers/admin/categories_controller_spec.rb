# spec/controllers/admin/categories_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let(:admin_user) { create(:user, admin: true) }

  before do
    # Assuming you have authentication in place
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
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
      get :edit, params: { id: category.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Category' do
        expect {
          post :create, params: { category: attributes_for(:category) }
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the categories list' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { category: attributes_for(:category, name: nil) }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Category Name' } }

      it 'updates the requested category' do
        put :update, params: { id: category.to_param, category: new_attributes }
        category.reload
        expect(category.name).to eq('Updated Category Name')
      end

      it 'redirects to the categories list' do
        put :update, params: { id: category.to_param, category: new_attributes }
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        put :update, params: { id: category.to_param, category: { name: nil } }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      category # Ensure the category is created before trying to delete it
      expect {
        delete :destroy, params: { id: category.to_param }
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete :destroy, params: { id: category.to_param }
      expect(response).to redirect_to(admin_categories_url)
    end
  end
end