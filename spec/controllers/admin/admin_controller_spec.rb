# spec/controllers/admin/admin_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::AdminController, type: :controller do
  controller do
    def index
      render plain: "Admin Area"
    end
  end

  let(:user) { create(:user) }
  let(:admin_user) { create(:user, admin: true) }

  describe "GET #index" do
    context "when user is not authenticated" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated but not an admin" do
      before do
        sign_in user
      end

      it "redirects back with an alert" do
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Admin only")
      end
    end

    context "when user is an admin" do
      before do
        sign_in admin_user
      end

      it "allows access to the admin area" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to eq("Admin Area")
      end
    end
  end
end