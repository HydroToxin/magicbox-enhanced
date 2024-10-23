# frozen_string_literal: true

# Todo
class Todo < ApplicationRecord
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  belongs_to :user

  validates :date, presence: true
  validates :body, presence: true

  default_scope { order('date ASC') }

  enum todo_status: { todo: 0, done: 1 }

  has_many :notifications, as: :notifiable, dependent: :delete_all

  def url
    Rails.application.routes.url_helpers.todos_path
  end

  def title
    "TODO: Scheduled at #{fdatetime(date)}"
  end

  def email_subject
    title.to_s
  end

  def notifiable_color
    'warning'
  end

  def notifiable_icon
    'clock'
  end

  def notifiable_url
    Setting.app_hostname + Rails.application.routes.url_helpers.todos_path
  end

  def text
    body
  end

  def message
    body
  end

  def color
    return 'orange' if todo?

    'lightgray' if done?
  end

  def start_date
    date
  end

  def end_date
    date + 1.hour
  end

  def late?
    return false if date.nil?

    date < DateTime.now
  end

  def self.notify
    pending_todos = Todo.todo.where('date < ?', DateTime.now)

    pending_todos.each do |todo|
      next unless todo.needs_notification?

      Notification.create(user: todo.user, notify_email: todo.notify_email?, notifiable: todo).notify
      todo.update(notified_date: todo.date)
    end
  end

  def needs_notification?
    notified_date.nil? || notified_date < (date - renotify_every_minute.minutes)
  end
end
