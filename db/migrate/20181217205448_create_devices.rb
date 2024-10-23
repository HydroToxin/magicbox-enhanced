# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :devices do |t|
      t.integer :device_type
      t.integer :device_state
      t.integer :pin_type, default: 0
      t.integer :pin_number, default: 0
      t.integer :default_duration, default: 1
      t.string :name
      t.string :product_reference
      t.string :custom_identifier
      t.float :watts, default: 0.0
      t.float :volts, default: 0.0
      t.float :amperes, :float, default: 0.0
      t.text :description
      t.datetime :last_start_date
      t.boolean :use_duration, default: false

      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
