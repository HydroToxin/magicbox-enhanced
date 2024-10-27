require 'rails_helper'

RSpec.describe Admin::DataTypesController, type: :controller do
  let(:user) { create(:user, admin: true) } # Assuming you have a User factory
  let(:data_type) { create(:data_type) } # Assuming you have a DataType factory

  before do
    sign_in user # Assuming you're using Devise for authentication
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: data_type.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new DataType" do
        expect {
          post :create, params: { data_type: attributes_for(:data_type) }
        }.to change(DataType, :count).by(1)
      end

      it "redirects to the data types list" do
        post :create, params: { data_type: attributes_for(:data_type) }
        expect(response).to redirect_to(admin_data_types_path)
      end
    end

    context "with invalid params" do
      it "renders the new template" do
        post :create, params: { data_type: attributes_for(:data_type, name: nil) }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "Updated Name" } }

      it "updates the requested data_type" do
        put :update, params: { id: data_type.to_param, data_type: new_attributes }
        data_type.reload
        expect(data_type.name).to eq("Updated Name")
      end

      it "redirects to the data types list" do
        put :update, params: { id: data_type.to_param, data_type: new_attributes }
        expect(response).to redirect_to(admin_data_types_path)
      end
    end

    context "with invalid params" do
      it "renders the edit template" do
        put :update, params: { id: data_type.to_param, data_type: { name: nil } }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested data_type" do
      data_type # Create the data_type
      expect {
        delete :destroy, params: { id: data_type.to_param }
      }.to change(DataType, :count).by(-1)
    end

    it "redirects to the data types list" do
      delete :destroy, params: { id: data_type.to_param }
      expect(response).to redirect_to(admin_data_types_path)
    end
  end
end