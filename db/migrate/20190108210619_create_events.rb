# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :events do |t|
      t.integer :event_type
      t.text :message
      t.json :data
      t.references :room, foreign_key: true
      t.references :device, foreign_key: true
      t.references :user, foreign_key: true
      t.references :eventable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
