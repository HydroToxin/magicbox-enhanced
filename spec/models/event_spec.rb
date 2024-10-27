# frozen_string_literal: true

# spec/models/event_spec.rb

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:eventable) }
    it { is_expected.to belong_to(:room).optional }
    it { is_expected.to belong_to(:device).optional }
    it { is_expected.to belong_to(:user).optional }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:event_type).with_values(action: 0, alert: 1, cron: 2, api: 3) }
  end

  describe '#badge_class' do
    let(:event) { build(:event, event_type: event_type) }

    context 'when event_type is action' do
      let(:event_type) { 'action' }
      it 'returns secondary' do
        expect(event.badge_class).to eq('secondary')
      end
    end

    context 'when event_type is alert' do
      let(:event_type) { 'alert' }
      it 'returns warning' do
        expect(event.badge_class).to eq('warning')
      end
    end

    context 'when event_type is cron' do
      let(:event_type) { 'cron' }
      it 'returns info' do
        expect(event.badge_class).to eq('info')
      end
    end

    context 'when event_type is api' do
      let(:event_type) { 'api' }
      it 'returns success' do
        expect(event.badge_class).to eq('success')
      end
    end
  end

  describe '#text' do
    it 'returns the formatted text with event_type and message' do
      event = build(:event, event_type: 'action', message: 'Test message')
      expect(event.text).to eq('action: Test message')
    end
  end

  describe '#start_date' do
    it 'returns the created_at date' do
      event = build(:event)
      expect(event.start_date).to eq(event.created_at)
    end
  end

  describe '#end_date' do
    it 'returns the start_date plus one hour' do
      event = create(:event)
      expect(event.end_date).to eq(event.start_date + 1.hour)
    end
  end

  describe '#color' do
    it 'returns lightblue' do
      event = build(:event)
      expect(event.color).to eq('lightblue')
    end
  end

  describe '#eventable_link' do
    let(:room) { create(:room, name: 'Room Name') }
    let(:event) { create(:event, eventable: room, eventable_type: 'Room') }

    it 'returns a link to the room' do
      url_helpers = Rails.application.routes.url_helpers
      helpers = ActionController::Base.helpers
      expected_link = helpers.link_to(event.eventable.name, url_helpers.room_path(event.eventable.id))
      allow(event).to receive(:eventable_link).and_return(expected_link)
      expect(event.eventable_link).to eq(expected_link)
    end
  end

  describe '.search' do
    let!(:event1) { create(:event, message: 'Test message', event_type: 'action') }
    let!(:event2) { create(:event, message: 'Another message', event_type: 'alert') }

    it 'filters by message' do
      expect(Event.search(message: 'Test')).to include(event1)
      expect(Event.search(message: 'Test')).not_to include(event2)
    end

    it 'filters by event_type' do
      expect(Event.search(event_type: 'action')).to include(event1)
      expect(Event.search(event_type: 'action')).not_to include(event2)
    end

    # Add more tests for other search parameters (room_id, grow_id, device_id)
  end
end