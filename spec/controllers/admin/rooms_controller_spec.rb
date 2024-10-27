# frozen_string_literal: true

# spec/controllers/admin/rooms_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::RoomsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:room) { create(:room) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all rooms to @rooms' do
      room = create(:room)
      get :index
      expect(assigns(:rooms)).to eq([room])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Room to @room' do
      get :new
      expect(assigns(:room)).to be_a_new(Room)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new room' do
        expect {
          post :create, params: { room: attributes_for(:room) }
        }.to change(Room, :count).by(1)
      end

      it 'redirects to the new room' do
        post :create, params: { room: attributes_for(:room) }
        expect(response).to redirect_to(Room.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new room' do
        expect {
          post :create, params: { room: attributes_for(:room, name: nil) }
        }.not_to change(Room, :count)
      end

      it 're-renders the new template' do
        post :create, params: { room: attributes_for(:room, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the room' do
        patch :update, params: { id: room.id, room: { name: 'Updated Name' } }
        room.reload
        expect(room.name).to eq('Updated Name')
      end

      it 'redirects to the updated room' do
        patch :update, params: { id: room.id, room: { name: 'Updated Name' } }
        expect(response).to redirect_to(room)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the room' do
        patch :update, params: { id: room.id, room: { name: nil } }
        room.reload
        expect(room.name).not_to be_nil
      end

      it 're-renders the edit template' do
        patch :update, params: { id: room.id, room: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the room' do
      room = create(:room)
      expect {
        delete :destroy, params: { id: room.id }
      }.to change(Room, :count).by(-1)
    end

    it 'redirects to rooms#index' do
      delete :destroy, params: { id: room.id }
      expect(response).to redirect_to(admin_rooms_url)
    end
  end
end