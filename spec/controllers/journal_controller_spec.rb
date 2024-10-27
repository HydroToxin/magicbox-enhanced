# frozen_string_literal: true

# spec/controllers/journal_controller_spec.rb

require 'rails_helper'

RSpec.describe JournalController, type: :controller do
  describe 'GET #index' do
    let!(:observations) { create_list(:observation, 3) }
    let!(:events) { create_list(:event, 5) }
    let(:user) { create(:user, admin: true) }

    before { sign_in user }

    it 'assigns all observations to @observations' do
      get :index
      expect(assigns(:observations)).to match_array(observations)
    end

    it 'assigns the latest 100 events ordered by created_at desc to @events' do
      get :index
      expect(assigns(:events)).to eq(events.sort_by(&:created_at).reverse.take(100))
    end

    it 'adds a breadcrumb for Journal' do
      expect(controller).to receive(:add_breadcrumb).with("Journal")
      expect(controller).to receive(:add_breadcrumb).with("Journal", nil, {})
      get :index
    end
  end
end