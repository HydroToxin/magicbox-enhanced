# frozen_string_literal: true

# Notification Model
class Notification < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :notifiable, polymorphic: true
  belongs_to :notified, polymorphic: true, optional: true
  belongs_to :user

  def notify
    return unless notify_email

    UserMailer.with(notification: self, user:).notification_email.deliver_now
  end
end
