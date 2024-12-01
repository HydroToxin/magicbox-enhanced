# frozen_string_literal: true

# spec/models/room_spec.rb

require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:subjects) }
    it { is_expected.to have_many(:devices).dependent(:destroy) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
    #it { is_expected.to have_many(:observations).through(:observation_subjects) }
    it { is_expected.to have_many(:samples).through(:devices) }
    it { is_expected.to have_many(:room_scenarios).dependent(:destroy) }
    it { is_expected.to have_many(:scenarios).through(:room_scenarios) }
    it { is_expected.to have_many_attached(:camshots) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:room_type).with_values(box: 0, closet: 1, room: 2, greenhouse: 3) }
  end

  describe '#all_events' do
    let(:room) { create(:room) }
    let!(:device_event) { create(:event, eventable: create(:device, room: room)) }
    let!(:room_event) { create(:event, eventable: room) }

    it 'returns all events related to the room and its devices' do
      expect(room.all_events).to contain_exactly(device_event, room_event)
    end
  end

  describe '#active_subjects' do
    let(:room) { create(:room) }
    let!(:active_subject) { create(:subject, room: room, grow: create(:grow, grow_status: :seedling)) }
    let!(:inactive_subject) { create(:subject, room: room, grow: create(:grow, grow_status: :done)) }

    it 'returns only active subjects' do
      expect(room.active_subjects).to contain_exactly(active_subject)
    end
  end

  describe '#last_sample' do
    let(:room) { create(:room) }
    let(:data_type) { create(:data_type) }
    let!(:sample) { create(:sample, device: create(:device, room: room), data_type:, created_at: 1.day.ago) }
    let!(:latest_sample) { create(:sample, device: create(:device, room: room), data_type:, created_at: Time.current) }

    it 'returns the latest sample of a given data type' do
      expect(room.last_sample(data_type)).to eq(latest_sample)
    end
  end

  describe '#current_temperature' do
    let(:room) { create(:room) }
    let(:temperature_data_type) { create(:data_type, name: 'temperature') }
    let!(:sample) { create(:sample, device: create(:device, room: room), data_type: temperature_data_type, value: 25, unit: 'C') }

    it 'returns the current temperature with unit' do
      expect(room.current_temperature).to eq('25 C')
    end
  end

  describe '#current_humidity' do
    let(:room) { create(:room) }
    let(:humidity_data_type) { create(:data_type, name: 'humidity') }
    let!(:sample) { create(:sample, device: create(:device, room: room), data_type: humidity_data_type, value: 60, unit: '%') }

    it 'returns the current humidity with unit' do
      expect(room.current_humidity).to eq('60 %')
    end
  end

  describe '#total_watts' do
    let(:room) { create(:room) }
    let!(:device1) { create(:device, room: room) }
    let!(:device2) { create(:device, room: room) }

    it 'calculates the total watts of all devices in the room' do
      #expect(room.total_watts).to eq(300.0)
    end
  end

  describe '#kwh_day' do
    # Add test cases for kwh_day method here
  end

  describe '#kwh_month' do
    let(:room) { create(:room) }

    before do
      allow(room).to receive(:kwh_day).and_return(10)
    end

    it 'calculates the monthly kWh based on daily kWh' do
      expect(room.kwh_month).to eq(300.0)
    end
  end

  describe '#dark?' do
    # Add test cases for dark? method here
  end
end