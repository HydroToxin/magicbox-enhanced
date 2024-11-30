# frozen_string_literal: true

class CreateDevicesDataTypes < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :devices_data_types do |t|
      t.references :device, foreign_key: true
      t.references :data_type, foreign_key: true
      t.string :unit
      t.timestamps
    end
  end
end
