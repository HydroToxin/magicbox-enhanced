# frozen_string_literal: true

# spec/models/alert_spec.rb

require 'rails_helper'

RSpec.describe Alert, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:data_type).optional }
    it { is_expected.to belong_to(:resource).optional }
    it { is_expected.to have_many(:alert_users) }
    it { is_expected.to have_many(:users).through(:alert_users) }
    it { is_expected.to have_many(:alert_push_users).class_name('AlertPushUser') }
    it { is_expected.to have_many(:push_users).through(:alert_push_users).source(:user) }
    it { is_expected.to have_many(:notifications).dependent(:delete_all) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_presence_of(:alert_type) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:alert_type).with_values(data_type_alert: 0, resource_alert: 1) }
    it {
      is_expected.to define_enum_for(:operator).with_values(
        equal: 0,
        not_equal: 1,
        lesser: 2,
        greater: 3,
        lesser_or_equal: 4,
        greater_or_equal: 5
      )
    }
  end

  describe '#title' do
    it 'returns the correct title' do
      alert = build(:alert)
      expect(alert.title).to eq('Alert')
    end
  end

  describe '#email_subject' do
    it 'returns the correct email subject' do
      alert = build(:alert)
      expect(alert.email_subject).to eq('ALERT: Alert')
    end
  end

  describe '#notifiable_color' do
    it 'returns the correct notifiable color' do
      alert = build(:alert)
      expect(alert.notifiable_color).to eq('danger')
    end
  end

  describe '#notifiable_icon' do
    it 'returns the correct notifiable icon' do
      alert = build(:alert)
      expect(alert.notifiable_icon).to eq('exclamation-triangle')
    end
  end

  describe '#notifiable_url' do
    it 'returns the correct notifiable URL' do
      allow(Setting).to receive(:app_hostname).and_return('http://example.com')
      alert = build(:alert)
      expect(alert.notifiable_url).to eq('http://example.com' + Rails.application.routes.url_helpers.notifications_path)
    end
  end

  describe '.trigger' do
    it 'logs the start and end of trigger alerts' do
      allow(MB_LOGGER).to receive(:info)
      described_class.trigger
      expect(MB_LOGGER).to have_received(:info).with('# Start Trigger Alerts ############').ordered
      expect(MB_LOGGER).to have_received(:info).with('# End Trigger Alerts ##############').ordered
    end
  end

  # Additional tests for the #trigger method would be needed here.
end