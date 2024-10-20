# frozen_string_literal: true

class CreateConditionGroups < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    create_table :condition_groups do |t|
      t.string :name
      t.boolean :enabled

      t.references :scenario, foreign_key: true

      t.timestamps
    end
  end
end
