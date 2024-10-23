# frozen_string_literal: true

class CreateScenarios < ActiveRecord::Migration[5.2]
  def change
    create_table :scenarios do |t|
      t.string :name
      t.string :description
      t.boolean :enabled, default: false
      t.boolean :scenarios, default: false

      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
