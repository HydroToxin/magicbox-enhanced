# frozen_string_literal: true

# spec/controllers/events_controller_spec.rb

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:event) { create(:event) }

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns @events and renders the index template' do
      get :index
      expect(assigns(:events)).to eq([event])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event to @event and renders the show template' do
      get :show, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new event to @event and renders the new template' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested event to @event and renders the edit template' do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new event and redirects to the event page with a notice' do
        event = FactoryBot.build(
          :event,
          device: create(:device),
          room: create(:room),
          user: user,
          eventable: create(:device)
        )
        expect {
          post :create, params: {
            event: event.attributes
          }
        }.to change(Event, :count).by(1)

        expect(response).to redirect_to(Event.last)
        expect(flash[:notice]).to eq('Event was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new event and re-renders the new template' do
        expect {
          post :create, params: { event: attributes_for(:event, event_type: nil) }
        }.not_to change(Event, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the event and redirects to the event page with a notice' do
        patch :update, params: { id: event.id, event: { message: 'Updated Message' } }
        event.reload
        expect(event.message).to eq('Updated Message')
        expect(response).to redirect_to(event)
        expect(flash[:notice]).to eq('Event was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the event and re-renders the edit template' do
        patch :update, params: { id: event.id, event: { event_type: nil } }
        expect(response).to redirect_to(event)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the event and redirects to events index with a notice' do
      delete :destroy, params: { id: event.id }
      expect(Event.exists?(event.id)).to be_falsey
      expect(response).to redirect_to(events_url)
      expect(flash[:notice]).to eq('Event was successfully destroyed.')
    end
  end
end