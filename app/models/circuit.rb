# frozen_string_literal: true

# Circuit Model
class Circuit < ApplicationRecord
  has_many :component_connections

  accepts_nested_attributes_for :component_connections,
    allow_destroy: true,
    reject_if: :all_blank

end