# frozen_string_literal: true

# Resource
class Resource < ApplicationRecord
  belongs_to :category
  has_many :resource_datas
end
