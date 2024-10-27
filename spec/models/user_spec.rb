# # frozen_string_literal: true

# # spec/models/user_spec.rb

# require 'rails_helper'

# RSpec.describe User, type: :model do
#   describe 'associations' do
#     it { is_expected.to have_many(:alert_users) }
#     it { is_expected.to have_many(:alerts).through(:alert_users) }
#     it { is_expected.to have_many(:observations) }
#     it { is_expected.to have_many(:notifications) }
#     it { is_expected.to have_many(:todos) }
#     it { is_expected.to have_many(:push_devices) }
#     it { is_expected.to have_many(:events) }
#   end

#   describe 'devise modules' do
#     it { is_expected.to be_database_authenticatable }
#     it { is_expected.to be_registerable }
#     it { is_expected.to be_recoverable }
#     it { is_expected.to be_rememberable }
#     it { is_expected.to be_validatable }
#   end

#   describe '#todos_count' do
#     let(:user) { create(:user) }
#     let!(:todo1) { create(:todo, user: user, todo_status: :todo) }
#     let!(:todo2) { create(:todo, user: user, todo_status: :done) }

#     it 'returns the count of todos with status todo' do
#       expect(user.todos_count).to eq(1)
#     end
#   end

#   describe '#unread_notifications_count' do
#     let(:user) { create(:user) }
#     let!(:notification1) { create(:notification, user: user, read: false) }
#     let!(:notification2) { create(:notification, user: user, read: true) }

#     it 'returns the count of unread notifications' do
#       expect(user.unread_notifications_count).to eq(1)
#     end
#   end

#   describe '#mark_notifications_as_read' do
#     let(:user) { create(:user) }
#     let!(:notification1) { create(:notification, user: user, read: false) }
#     let!(:notification2) { create(:notification, user: user, read: false) }

#     it 'marks all unread notifications as read' do
#       user.mark_notifications_as_read
#       expect(user.notifications.where(read: false).count).to eq(0)
#     end
#   end

#   describe '#generate_auth_qr' do
#     let(:user) { create(:user) }
#     let(:size) { 5 }

#     it 'generates a QR code in base64 format' do
#       qr_code = user.generate_auth_qr(user, size)
#       expect(qr_code).to start_with('data:image/png;base64,')
#     end
#   end
# end