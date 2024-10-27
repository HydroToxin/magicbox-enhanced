# frozen_string_literal: true

# spec/models/setting_spec.rb

require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe 'default values' do
    it 'returns the correct default for app_hostname' do
      expect(Setting.app_hostname).to eq('http://locahlhost')
    end

    it 'returns the correct default for app_email' do
      expect(Setting.app_email).to eq('no-reply@magicbox.example.org')
    end

    it 'returns the correct default for openweather_city' do
      expect(Setting.openweather_city).to eq('Narbonne')
    end

    it 'returns the correct default for openweather_endpoint' do
      expect(Setting.openweather_endpoint).to eq('http://api.openweathermap.org/data/2.5/weather')
    end

    it 'returns the correct default for time_zone' do
      expect(Setting.time_zone).to eq('Europe/Paris')
    end

    it 'returns the correct default for date_format' do
      expect(Setting.date_format).to eq('DD.MM.YYYY')
    end

    it 'returns the correct default for time_format' do
      expect(Setting.time_format).to eq('hh:mm')
    end

    it 'returns the correct default for rails_date_format' do
      expect(Setting.rails_date_format).to eq('%d.%m.%Y')
    end

    it 'returns the correct default for rails_time_format' do
      expect(Setting.rails_time_format).to eq('%H:%M')
    end

    it 'returns the correct default for calendar_default_view' do
      expect(Setting.calendar_default_view).to eq('month')
    end

    it 'returns the correct default for calendar_weeks_enabled' do
      expect(Setting.calendar_weeks_enabled).to be(true)
    end

    it 'returns the correct default for calendar_todos_enabled' do
      expect(Setting.calendar_todos_enabled).to be(true)
    end

    it 'returns the correct default for calendar_issues_enabled' do
      expect(Setting.calendar_issues_enabled).to be(true)
    end

    it 'returns the correct default for calendar_observations_enabled' do
      expect(Setting.calendar_observations_enabled).to be(true)
    end

    it 'returns the correct default for units_weight' do
      expect(Setting.units_weight).to eq('g')
    end

    it 'returns the correct default for units_currency' do
      expect(Setting.units_currency).to eq('€')
    end
  end
end