# frozen_string_literal: true

# spec/models/device_spec.rb

require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:room) }
    it { is_expected.to have_many(:samples).dependent(:delete_all) }
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:devices_data_types).dependent(:delete_all) }
    it { is_expected.to have_many(:data_types).through(:devices_data_types) }
    it { is_expected.to have_many(:notifications) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "Polymorphic Association" do
    it "has a polymorphic association with events" do
      event = Event.create(eventable: Device.new)
      expect(event.eventable_type).to eq("Device")
    end
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:device_state).with_values(off: 0, on: 1, idle: 2, starting: 3, stopping: 4) }
    it { is_expected.to define_enum_for(:pin_type).with_values(digital: 0, analog: 1) }
  end

  describe '#last_sample' do
    let(:device) { create(:device) }
    let(:data_type) { create(:data_type) }
    let!(:sample) { create(:sample, device:, data_type:) }

    it 'returns the last sample for a given data type' do
      expect(device.last_sample(data_type)).to eq(sample)
    end
  end

  describe '#start' do
    let(:device) { create(:device, device_state: :off) }

    context 'when device type is power_strip with silvershield_pms' do
      before do
        allow(device).to receive(:device_type).and_return('power_strip')
        allow(device).to receive(:product_reference).and_return('silvershield_pms')
        allow(device).to receive(:start_power_strip).and_return(true)
      end

      it 'calls start_power_strip method' do
        expect(device.start).to be_truthy
      end
    end

    context 'when device state changes from off to on' do
      it 'updates the device state to on' do
        expect { device.start }.to change(device, :device_state).from('off').to('on')
      end
    end
  end

  describe '#stop' do
    let(:device) { create(:device, device_state: :on) }

    context 'when device type is power_strip with silvershield_pms' do
      before do
        allow(device).to receive(:device_type).and_return('power_strip')
        allow(device).to receive(:product_reference).and_return('silvershield_pms')
        allow(device).to receive(:stop_power_strip).and_return(true)
      end

      it 'calls stop_power_strip method' do
        expect(device.stop).to be_truthy
      end
    end

    context 'when device state changes from on to off' do
      it 'updates the device state to off' do
        expect { device.stop }.to change(device, :device_state).from('on').to('off')
      end
    end
  end

  # Additional tests for other methods can be added here...
end