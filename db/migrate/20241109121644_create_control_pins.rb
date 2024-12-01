class CreateControlPins < ActiveRecord::Migration[7.1]
  def change
    create_table :control_pins do |t|
      t.string :name, null: false
      t.integer :pin_number, null: false
      t.string :pin_color
      t.boolean :left
      t.boolean :right
      t.integer :com_number
      t.string :pin_function
      t.string :signal_type
      t.string :signal_mode
      t.string :pull_resistor
      t.string :initial_state
      t.string :voltage
      t.string :description

      t.references :component, foreign_key: true

      t.timestamps
    end
  end
end
