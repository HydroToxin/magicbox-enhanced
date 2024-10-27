# frozen_string_literal: true

# spec/controllers/admin/settings_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::SettingsController, type: :controller do
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  let(:valid_attributes) do
    {
      app_email: 'test@example.com',
      app_hostname: 'example.com',
      openweather_city: 'New York',
      openweather_endpoint: 'http://api.openweathermap.org',
      time_zone: 'UTC',
      date_format: '%Y-%m-%d',
      time_format: '%H:%M',
      rails_date_format: '%d/%m/%Y',
      rails_time_format: '%I:%M %p',
      calendar_default_view: 'month',
      calendar_weeks_enabled: true,
      calendar_todos_enabled: true,
      calendar_issues_enabled: false,
      calendar_observations_enabled: false,
      units_weight: 'kg',
      units_currency: 'USD'
    }
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      get :show
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      get :show
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'updates the settings' do
        post :create, params: { setting: valid_attributes }
        valid_attributes.each_key do |key|
          expect(Setting.send(key)).to eq(valid_attributes[key])
        end
      end

      it 'redirects to the settings page with a notice' do
        post :create, params: { setting: valid_attributes }
        expect(response).to redirect_to(admin_settings_path)
        expect(flash[:notice]).to eq('Settings were successfully updated.')
      end
    end

    context 'with some nil attributes' do
      it 'does not update nil attributes' do
        modified_attributes = valid_attributes.merge(app_email: nil)
        post :create, params: { setting: modified_attributes }
        expect(Setting.app_email).not_to be_nil
      end
    end
  end
end
