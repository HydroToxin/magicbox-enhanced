# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :devices do |t|
      t.integer :device_type
      t.integer :device_state
      t.integer :default_duration, default: 1
      t.string :name
      t.string :product_reference
      t.string :custom_identifier
      t.text :description
      t.datetime :last_start_date
      t.boolean :use_duration, default: false

      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
