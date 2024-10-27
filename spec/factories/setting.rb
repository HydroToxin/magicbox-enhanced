# frozen_string_literal: true

FactoryBot.define do
  factory :setting do
    app_email { 'test@example.com' }
    app_hostname { 'example.com' }
    openweather_city { 'New York' }
    openweather_endpoint { 'http://api.openweathermap.org' }
    time_zone { 'UTC' }
    date_format { '%Y-%m-%d' }
    time_format { '%H:%M' }
    rails_date_format { '%d/%m/%Y' }
    rails_time_format { '%I:%M %p' }
    calendar_default_view { 'month' }
    calendar_weeks_enabled { true }
    calendar_todos_enabled { true }
    calendar_issues_enabled { false }
    calendar_observations_enabled { false }
    units_weight { 'kg' }
    units_currency { 'USD' }
  end
end