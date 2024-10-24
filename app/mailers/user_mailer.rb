# frozen_string_literal: true

# Mailer for all user related emails
class UserMailer < ApplicationMailer
  helper ApplicationHelper

  default from: Setting.app_email

  def notification_email
    @user = params[:user]
    @notification = params[:notification]

    mail(to: @user.email, subject: @notification.notifiable.email_subject)
  end
end
