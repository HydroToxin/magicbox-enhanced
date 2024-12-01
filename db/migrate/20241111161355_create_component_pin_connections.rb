class CreateComponentPinConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :component_pin_connections do |t|
      t.references :source_control_pin, null: false, foreign_key: { to_table: :control_pins }
      t.references :target_control_pin, null: false, foreign_key: { to_table: :control_pins }
      t.references :component_connection

      t.timestamps
    end
  end
end
