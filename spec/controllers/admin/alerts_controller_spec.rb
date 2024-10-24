# spec/controllers/admin/alerts_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::AlertsController, type: :controller do
  let(:admin_user) { create(:user, admin: true) }
  let(:alert) { create(:alert) }

  before do
    sign_in admin_user
  end

  describe "GET #index" do
    it "assigns all alerts as @alerts" do

      alert = create(:alert)

      get :index
      expect(assigns(:alerts)).to eq([alert])
    end
  end

  describe "GET #show" do
    it "assigns the requested alert as @alert" do
      get :show, params: { id: alert.to_param }
      expect(assigns(:alert)).to eq(alert)
    end
  end

  describe "GET #new" do
    it "assigns a new alert as @alert" do
      get :new
      expect(assigns(:alert)).to be_a_new(Alert)
    end
  end

  describe "GET #edit" do
    it "assigns the requested alert as @alert" do
      get :edit, params: { id: alert.to_param }
      expect(assigns(:alert)).to eq(alert)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) { attributes_for(:alert) }

      it "creates a new Alert" do
        expect {
          post :create, params: { alert: valid_attributes }
        }.to change(Alert, :count).by(1)
      end

      it "redirects to the alerts list" do
        post :create, params: { alert: valid_attributes }
        expect(response).to redirect_to(admin_alerts_url)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { attributes_for(:alert, alert_type: nil) }

      it "does not create a new Alert" do
        expect {
          post :create, params: { alert: invalid_attributes }
        }.not_to change(Alert, :count)
      end

      it "renders the new template" do
        post :create, params: { alert: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { message: "Updated Message" } }

      it "updates the requested alert" do
        put :update, params: { id: alert.to_param, alert: new_attributes }
        alert.reload
        expect(alert.message).to eq("Updated Message")
      end

      it "redirects to the alerts list" do
        put :update, params: { id: alert.to_param, alert: new_attributes }
        expect(response).to redirect_to(admin_alerts_url)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { alert_type: nil } }

      it "does not update the alert" do
        put :update, params: { id: alert.to_param, alert: invalid_attributes }
        alert.reload
        expect(alert.alert_type).not_to be_nil
      end

      it "renders the edit template" do
        put :update, params: { id: alert.to_param, alert: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested alert" do
      alert = create(:alert)
      expect {
        delete :destroy, params: { id: alert.to_param }
      }.to change(Alert, :count).by(-1)
    end

    it "redirects to the alerts list" do
      delete :destroy, params: { id: alert.to_param }
      expect(response).to redirect_to(admin_alerts_url)
    end
  end

  describe "POST #test" do
    it "tests the alert" do
      expect_any_instance_of(Alert).to receive(:test_alert)
      post :test, params: { id: alert.to_param }
      expect(response).to redirect_to(request.referrer || admin_alerts_url)
    end
  end

  describe "POST #trigger" do
    it "triggers the alert" do
      expect_any_instance_of(Alert).to receive(:trigger)
      post :trigger, params: { id: alert.to_param }
      expect(response).to redirect_to(request.referrer || admin_alerts_url)
    end
  end
end