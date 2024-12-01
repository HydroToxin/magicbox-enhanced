# frozen_string_literal: true

# Circuit PinConnection
class ComponentPinConnection < ApplicationRecord
  belongs_to :component_connection
  belongs_to :source_control_pin, class_name: 'ControlPin', foreign_key: :source_control_pin_id
  belongs_to :target_control_pin, class_name: 'ControlPin', foreign_key: :target_control_pin_id
end