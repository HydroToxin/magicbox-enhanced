# frozen_string_literal: true

# ObservationResource
class ObservationResource < ApplicationRecord
  self.table_name = 'observation_resources'
  belongs_to :resource
  belongs_to :observation

  attr_accessor :category_id
end
