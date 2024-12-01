# frozen_string_literal: true

# Notifications controller
class NotificationsController < ApplicationController
  before_action :authenticate_user!

  #add_breadcrumb 'Notifications'

  def index
    @notifications = current_user.notifications.paginate(page: params[:page], per_page: 100)

    current_user.mark_notifications_as_read
  end

  def destroy
    @notification = Notification.find(params[:id])

    @notification.destroy

    redirect_to notifications_path, notice: 'Notification was successfully destroyed.'
  end

  def clear_all
    Notification.all.each(&:destroy)

    if request.referrer.present?
      redirect_to request.referrer, notice: 'All notifications successfully deleted.'
    else
      redirect_to notifications_path, notice: 'All notifications successfully deleted.'
    end


  end
end
