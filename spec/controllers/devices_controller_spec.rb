# frozen_string_literal: true

# spec/controllers/devices_controller_spec.rb

require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:room) { create(:room) }
  let(:device) { create(:device, room: room) }
  let(:data_type) { create(:data_type, name: 'temperature') }

  before { sign_in user }

  describe 'GET #index' do
    context 'when room_id is provided' do
      before { get :index, params: { room_id: room.id } }

      it 'sets the @room instance variable' do
        expect(assigns(:room)).to eq(room)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #show' do
    let!(:samples) { create_list(:sample, 5, device: device, data_type: data_type) }

    before { get :show, params: { id: device.id, room_id: room.id } }

    it 'assigns @device' do
      expect(assigns(:device)).to eq(device)
    end

    it 'assigns @samples limited to 100' do
      expect(assigns(:samples).count).to be <= 100
    end

    it 'assigns @values with temperature data ordered by created_at desc' do
      expected_values = samples.sort_by(&:created_at).reverse.map { |e| [e.created_at, e.value] }
      expect(assigns(:values)).to eq(expected_values)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #query' do
    context 'when query succeeds' do
      before do
        allow_any_instance_of(Device).to receive(:query_sensor).and_return(true)
        post :query, params: { id: device.id, room_id: room.id }
      end

      it 'redirects to the room path with a success notice' do
        expect(response).to redirect_to(room_path(room))
        expect(flash[:notice]).to eq('Query device succeeded.')
      end
    end

    context 'when query fails' do
      before do
        allow_any_instance_of(Device).to receive(:query_sensor).and_return(false)
        post :query, params: { id: device.id, room_id: room.id }
      end

      it 'redirects to the room path with an alert' do
        expect(response).to redirect_to(room_path(room))
        expect(flash[:alert]).to eq('Query device failed.')
      end
    end
  end
end