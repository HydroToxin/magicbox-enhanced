# frozen_string_literal: true

class CreateIssues < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :issues do |t|
      t.integer :severity
      t.integer :issue_type
      t.integer :issue_status

      t.references :resource, foreign_key: true
      t.references :observation, foreign_key: true

      t.timestamps
    end
  end
end
