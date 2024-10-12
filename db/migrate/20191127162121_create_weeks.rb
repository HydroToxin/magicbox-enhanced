class CreateWeeks < ActiveRecord::Migration[5.2]
    disable_ddl_transaction!
    def change
    create_table :weeks do |t|
      t.integer :week_number
      t.integer :week_type
      t.date :start_date
      t.date :end_date
      t.uuid :uuid, null: false, default: -> { "gen_random_uuid()" }
      t.references :grow, foreign_key: true

      t.timestamps
    end
  end
end