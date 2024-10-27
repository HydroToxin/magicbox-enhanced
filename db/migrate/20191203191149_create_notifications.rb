# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.boolean :notify_email
      t.string :notified_type
      t.bigint :notified_id
      t.string :notifiable_type
      t.bigint :notifiable_id

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
