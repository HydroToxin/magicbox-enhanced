# frozen_string_literal: true

# spec/controllers/rooms_controller_spec.rb

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { create(:user, admin: true ) }
  let(:room) { create(:room) }
  let!(:camera) { create(:device, device_type: :camera, room:) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'assigns the requested room to @room' do
      get :show, params: { id: room.id }
      expect(assigns(:room)).to eq(room)
    end

    it 'adds a breadcrumb with the room name' do
      expect(controller).to receive(:add_breadcrumb).with(room.name, room)
      get :show, params: { id: room.id }
    end

    it 'assigns the first camera device to @camera' do
      get :show, params: { id: room.id }
      expect(assigns(:camera)).to eq(camera)
    end
  end
end