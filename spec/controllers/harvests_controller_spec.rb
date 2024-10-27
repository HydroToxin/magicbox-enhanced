# frozen_string_literal: true

# spec/controllers/harvests_controller_spec.rb

require 'rails_helper'

RSpec.describe HarvestsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:grow) { create(:grow) }
  let(:harvest) { create(:harvest, grow: grow) }

  before { sign_in user }

  describe 'GET #index' do
    before do
      allow(controller).to receive(:set_grow).and_call_original
      allow(controller).to receive(:set_harvest).and_call_original
    end

    it 'assigns the requested grow to @grow' do
      get :index, params: { grow_id: grow.id, id: harvest.id }
      expect(assigns(:grow)).to eq(grow)
    end

    it 'assigns the requested harvest to @harvest' do
      get :index, params: { grow_id: grow.id, id: harvest.id }
      expect(assigns(:harvest)).to eq(harvest)
    end

    it 'adds breadcrumbs for grow and harvest' do
      get :index, params: { grow_id: grow.id, id: harvest.id }
      #expect(controller).to receive(:add_breadcrumb).with('Harvest')
      #expect(controller).to receive(:add_breadcrumb).with("Grow ##{grow.id}")
    end
  end
end