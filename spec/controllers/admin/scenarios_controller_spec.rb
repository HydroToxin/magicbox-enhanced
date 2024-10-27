# frozen_string_literal: true

# spec/controllers/admin/scenarios_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::ScenariosController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:scenario) { create(:scenario) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new Scenario to @scenario' do
      get :new
      expect(assigns(:scenario)).to be_a_new(Scenario)
    end

    it 'builds a new condition group for the scenario' do
      get :new
      expect(assigns(:scenario).condition_groups.size).to eq(1)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new scenario' do
        expect {
          post :create, params: { scenario: attributes_for(:scenario) }
        }.to change(Scenario, :count).by(1)
      end

      it 'redirects to the new scenario' do
        post :create, params: { scenario: attributes_for(:scenario) }
        expect(response).to redirect_to(admin_scenario_path(Scenario.last))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new scenario' do
        expect {
          post :create, params: { scenario: attributes_for(:scenario, name: nil) }
        }.not_to change(Scenario, :count)
      end

      it 're-renders the new template' do
        post :create, params: { scenario: attributes_for(:scenario, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the scenario' do
        patch :update, params: { id: scenario.id, scenario: { name: 'Updated Name' } }
        scenario.reload
        expect(scenario.name).to eq('Updated Name')
      end

      it 'redirects to the updated scenario' do
        patch :update, params: { id: scenario.id, scenario: { name: 'Updated Name' } }
        expect(response).to redirect_to(admin_scenario_path(scenario))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the scenario' do
        patch :update, params: { id: scenario.id, scenario: { name: nil } }
        scenario.reload
        expect(scenario.name).not_to be_nil
      end

      it 're-renders the edit template' do
        patch :update, params: { id: scenario.id, scenario: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the scenario' do
      scenario = create(:scenario)
      expect {
        delete :destroy, params: { id: scenario.id }
      }.to change(Scenario, :count).by(-1)
    end

    it 'redirects to scenarios#index' do
      delete :destroy, params: { id: scenario.id }
      expect(response).to redirect_to(admin_scenarios_url)
    end
  end
end