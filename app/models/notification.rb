class Notification < ApplicationRecord
	default_scope { order(created_at: :desc) }

	belongs_to :notifiable, polymorphic: true
	belongs_to :notified, polymorphic: true, optional: true
	belongs_to :user

	def notify
		if notify_email
			UserMailer.with(notification: self, user: user).notification_email.deliver_now
		end
	end
end
