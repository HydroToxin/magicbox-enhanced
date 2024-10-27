# frozen_string_literal: true

# spec/models/notification_spec.rb

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:notifiable) }
    it { is_expected.to belong_to(:notified).optional }
    it { is_expected.to belong_to(:user) }
  end

  describe 'default scope' do
    let!(:older_notification) { create(:notification, created_at: 1.day.ago) }
    let!(:newer_notification) { create(:notification, created_at: Time.zone.now) }

    it 'orders by created_at descending' do
      expect(Notification.all).to eq([newer_notification, older_notification])
    end
  end

  describe '#notify' do
    let(:user) { create(:user) }
    let(:notification) { build(:notification, user:, notify_email:) }

    context 'when notify_email is true' do
      let(:notify_email) { true }

      it 'sends a notification email' do
        mailer_double = instance_double(ActionMailer::MessageDelivery, deliver_now: true)
        allow(UserMailer).to receive_message_chain(:with, :notification_email).and_return(mailer_double)

        notification.notify

        expect(UserMailer).to have_received(:with).with(notification:, user:)
        expect(mailer_double).to have_received(:deliver_now)
      end
    end

    context 'when notify_email is false' do
      let(:notify_email) { false }

      it 'does not send a notification email' do
        allow(UserMailer).to receive(:with)

        notification.notify

        expect(UserMailer).not_to have_received(:with)
      end
    end
  end
end
