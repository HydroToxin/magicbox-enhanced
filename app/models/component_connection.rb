# frozen_string_literal: true

# Component Connection Model
class ComponentConnection < ApplicationRecord
  belongs_to :source_component, class_name: 'Component', foreign_key: :source_component_id
  belongs_to :target_component, class_name: 'Component', foreign_key: :target_component_id
  belongs_to :circuit

  has_many :component_pin_connections

  accepts_nested_attributes_for :component_pin_connections,
    allow_destroy: true,
    reject_if: :all_blank

end