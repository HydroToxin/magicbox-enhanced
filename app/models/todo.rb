# frozen_string_literal: true

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

  def is_late?
    return if date.nil?

    date < DateTime.now
  end

  def self.notify
    now   = DateTime.now
    todos = Todo.where(todo_status: :todo).where('date < ?', now)
    # todos = todos.where('notified_date IS NULL OR notified_date < ?', now - todo.renotify_every_minute)
    logger.info todos.count

    todos.each do |todo|
      logger.info "todo.notified_date : #{todo.notified_date}"
      logger.info "now - todo.renotify_every_minute : #{now - todo.renotify_every_minute.minutes}"
      next unless (todo.notified_date.nil? ||
         (todo.notified_date < (now - todo.renotify_every_minute.minutes))) && todo.notify_email?

      Notification.create(user: todo.user, notify_email: todo.notify_email?, notifiable: todo).notify

      todo.notified_date = now
      todo.save
    end
  end
end
