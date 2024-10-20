# frozen_string_literal: true

class CreateAlertPushUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :alert_push_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :alert, null: false, foreign_key: { to_table: :alerts }

      t.timestamps
    end
  end
end
