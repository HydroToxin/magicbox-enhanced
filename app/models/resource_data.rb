# frozen_string_literal: true

# ResourceData
class ResourceData < ApplicationRecord
  self.table_name = 'resource_datas'
  belongs_to :resource
  # belongs_to :subject
  belongs_to :observation

  attr_accessor :category_id
end
