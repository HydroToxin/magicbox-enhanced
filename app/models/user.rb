class User < ApplicationRecord
	acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :alert_users
  has_many :alerts, through: :alert_users

  has_many :observations
  has_many :notifications
  has_many :todos
  has_many :push_devices
  has_many :events

  def todos_count
    todos.where(todo_status: :todo).count
  end

  def unread_notifications_count
  	notifications.where(read: false).count
  end

  def mark_notifications_as_read
    notifications.where(read: false).update_all(read: true)
  end

  def generate_auth_qr(current_user, size)
    require 'barby'
    require 'barby/barcode'
    require 'barby/barcode/qr_code'
    require 'barby/outputter/png_outputter'

    string = "#{Setting.app_hostname}/#{current_user.email}/#{authentication_token}"

    barcode = Barby::QrCode.new(string, level: :q, size: 6)
    "data:image/png;base64,#{Base64.strict_encode64(barcode.to_png({ xdim: size }))}"
  end
end
