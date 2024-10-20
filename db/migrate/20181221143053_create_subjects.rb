# frozen_string_literal: true

class CreateSubjects < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :birth_type, default: 0

      t.references :room, foreign_key: true
      t.references :grow, foreign_key: true
      t.references :mother, foreign_key: { to_table: :subjects }, on_delete: :nullify, null: true, default: nil
      t.references :strain, foreign_key: true

      t.timestamps
    end
  end
end
