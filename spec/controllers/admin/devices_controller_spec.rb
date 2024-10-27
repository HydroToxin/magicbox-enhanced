# frozen_string_literal: true

# spec/controllers/admin/devices_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::DevicesController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:room) { create(:room) }
  let(:device) { create(:device, room: room) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all devices as @devices' do
      device
      get :index, params: { room_id: room.id }
      expect(assigns(:devices)).to include(device)
    end

    it 'sorts devices by specified column and direction' do
      device
      get :index, params: { sort_column: 'name', sort_direction: 'desc', room_id: room.id }
      expect(assigns(:devices).order_values).to eq(['name desc'])
    end

    it 'limits the number of devices returned' do
      device
      get :index, params: { limit: 1, room_id: room.id }
      expect(assigns(:devices).size).to eq(1)
    end

    it 'offsets the devices returned' do
      create_list(:device, 3, room: room)
      get :index, params: { offset: 2, room_id: room.id }
      expect(assigns(:devices).size).to eq(1)
    end
  end

  describe 'GET #new' do
    it 'assigns a new device as @device' do
      get :new, params: { room_id: room.id }
      expect(assigns(:device)).to be_a_new(Device)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested device as @device' do
      get :edit, params: { id: device.to_param, room_id: room.id }
      expect(assigns(:device)).to eq(device)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:device).merge(room_id: room.id) }

      it 'creates a new Device' do
        expect do
          post :create, params: { device: valid_attributes, room_id: room.id }
        end.to change(Device, :count).by(1)
      end

      it 'redirects to the created device' do
        post :create, params: { device: valid_attributes, room_id: room.id }
        expect(response).to redirect_to(room_device_path(room, Device.last))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:device, name: nil).merge(room_id: room.id) }

      it 'renders the new template' do
        post :create, params: { device: invalid_attributes, room_id: room.id }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Name' } }

      it 'updates the requested device' do
        put :update, params: { id: device.to_param, device: new_attributes, room_id: room.id }
        device.reload
        expect(device.name).to eq('Updated Name')
      end

      it 'redirects to the device' do
        put :update, params: { id: device.to_param, device: new_attributes, room_id: room.id }
        expect(response).to redirect_to(room_device_path(room, device))
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        put :update, params: { id: device.to_param, device: { name: nil }, room_id: room.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested device' do
      device
      expect do
        delete :destroy, params: { id: device.to_param, room_id: room.id }
      end.to change(Device, :count).by(-1)
    end

    it 'redirects to the room path' do
      delete :destroy, params: { id: device.to_param, room_id: room.id }
      expect(response).to redirect_to(room_path(room))
    end
  end

  describe 'POST #start' do
    before do
      allow(device).to receive(:start)
    end

    it 'starts the device and redirects back with notice' do
      allow(device).to receive(:start).and_return(true)
      post :start, params: { id: device.to_param, room_id: room.id }
      expect(response).to redirect_back(fallback_location: room_path(room))
      expect(flash[:notice]).to eq('Device started')
    end

    it 'fails to start the device and redirects back with alert' do
      result = 'Start failed'
      allow(controller).to receive(:start).and_raise(StandardError, "Device error: #{result}")
      expect {
        post :start, params: { id: device.id, room_id: room.id }
        expect(flash[:alert]).to eq('Device error: #{result}')
      }.to raise_error(StandardError, "Device error: #{result}")
    end
  end

  describe 'POST #stop' do
    before do
      allow(device).to receive(:stop)
    end

    it 'stops the device and redirects back with notice' do
      allow(device).to receive(:stop).and_return(true)
      post :stop, params: { id: device.to_param, room_id: room.id }
      expect(response).to redirect_back(fallback_location: room_path(room))
      expect(flash[:notice]).to eq('Device stopped')
    end

    it 'fails to stop the device and redirects back with alert' do
      result = 'Stop failed'
      allow(controller).to receive(:stop).and_raise(StandardError, "Device error: #{result}")
      expect {
        post :stop, params: { id: device.id, room_id: room.id }
        expect(flash[:alert]).to eq('Device error: #{result}')
      }.to raise_error(StandardError, "Device error: #{result}")
    end
  end
end