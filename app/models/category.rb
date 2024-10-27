# frozen_string_literal: true

# Category Model
class Category < ApplicationRecord
  has_many :resources

  validates :name, presence: true
end
