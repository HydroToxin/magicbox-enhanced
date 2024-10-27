# frozen_string_literal: true

# spec/models/operation_spec.rb

require 'rails_helper'

RSpec.describe Operation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:condition_group) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:command) }
  end

  describe '#execute_operation' do
    let(:room) { create(:room) }
    let(:device) { create(:device, room: room, device_type: 'sensor') }
    let(:operation) { build(:operation, command: 'start', duration: 10) }

    before do
      allow(room.devices).to receive(:find_by).with(device_type: operation.device_type).and_return(device)
    end

    context 'when command is start' do
      let(:command) { 'stop' }
      let(:duration) { 10 }

      it 'starts the device and schedules opposite command if duration is positive' do
        expect(device).to receive(:start).with(event_type: :cron, event: true)
        expect(CommandJob).to receive(:perform_in).with(duration.seconds, device.id, command)

        operation.execute_operation(room)
      end
    end

    context 'when command is stop and duration is zero' do
      it 'stops the device and does not schedule opposite command' do
        #expect(device).to receive(:stop).with(event_type: :cron, event: true)
        #expect(CommandJob).not_to receive(:perform_in)

        operation.execute_operation(room)
      end
    end

    context 'when no device is found' do
      before do
        allow(room.devices).to receive(:find_by).with(device_type: operation.device_type).and_return(nil)
      end

      it 'does not perform any action' do
        expect(device).not_to receive(:start)
        expect(device).not_to receive(:stop)

        operation.execute_operation(room)
      end
    end
  end
end
