# frozen_string_literal: true

# Alert Push User
class AlertPushUser < ApplicationRecord
  belongs_to :alert
  belongs_to :user
end
