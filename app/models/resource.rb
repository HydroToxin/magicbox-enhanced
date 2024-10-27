# frozen_string_literal: true

# Resource
class Resource < ApplicationRecord
  belongs_to :category
  has_many :resource_datas

  validates :name, presence: true
  validates :shortname, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :choices, presence: true
  validates :units, presence: true

end
