# frozen_string_literal: true

# Datatype
class DataType < ApplicationRecord
  has_many :samples

  has_many :devices_data_types
  has_many :devices
end
