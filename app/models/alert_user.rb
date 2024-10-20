# frozen_string_literal: true

class AlertUser < ApplicationRecord
  belongs_to :alert
  belongs_to :user, class_name: 'User', foreign_key: :user_id
end
