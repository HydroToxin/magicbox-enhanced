# frozen_string_literal: true

class AlertPushUser < ApplicationRecord
  belongs_to :alert
  belongs_to :user
end
