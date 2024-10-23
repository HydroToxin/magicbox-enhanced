# frozen_string_literal: true

class CreateAlertUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :alert_users do |t|
      t.references :alert, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
