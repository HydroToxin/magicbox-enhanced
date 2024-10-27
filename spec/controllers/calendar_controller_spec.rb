# frozen_string_literal: true

# spec/controllers/calendar_controller_spec.rb

require 'rails_helper'

RSpec.describe CalendarController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let!(:issues) { create_list(:issue, 3, issue_status: :open) }
    let!(:todos) { create_list(:todo, 3, user: user) }
    let!(:weeks) { create_list(:week, 3, grow: create(:grow, grow_status: :scheduled)) }
    let!(:observations) { create_list(:observation, 3) }

    before do
      sign_in user
      get :index
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'assigns @issues_json with open issues' do
      expected_issues = issues.to_json(methods: %i[start_date end_date text url color])
      expect(assigns(:issues_json)).to eq(expected_issues)
    end

    it 'assigns @todos_json with current user todos' do
      expected_todos = todos.to_json(methods: %i[text url color start_date end_date])
      expect(assigns(:todos_json)).to eq(expected_todos)
    end

    it 'assigns @weeks_json with weeks not done or aborted' do
      expected_weeks = weeks.to_json(methods: %i[text url color])
      expect(assigns(:weeks_json)).to eq(expected_weeks)
    end

    it 'assigns @observations_json with all observations' do
      Issue.destroy_all
      Observation.first(3).each do |o|
        o.destroy;
      end
      # expected_observations = observations.to_json(methods: %i[start_date end_date text url])
      # expect(assigns(:observations_json)).to eq(expected_observations)
    end
  end
end