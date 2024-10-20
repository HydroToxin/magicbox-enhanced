class CreateConditions < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :conditions do |t|
      t.integer :predicate
      t.integer :target_value
      t.integer :condition_type, default: 0
      t.integer :logic, default: 0
      t.integer :duration
      t.time :start_time
      t.time :end_time
      t.datetime :last_duration_checked_at

      t.references :data_type, foreign_key: true
      t.references :condition_group, foreign_key: true

      t.timestamps
    end
  end
end
