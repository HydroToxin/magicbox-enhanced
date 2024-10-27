# frozen_string_literal: true

class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.integer :alert_type
      t.integer :operator
      t.boolean :enabled
      t.boolean :push_enabled
      t.float :value
      t.text :message
      t.datetime :alerts

      t.references :data_type, foreign_key: true
      t.references :resource, foreign_key: { to_table: :resources }

      t.timestamps
    end
  end
end
