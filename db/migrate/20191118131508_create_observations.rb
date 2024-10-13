class CreateObservations < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :observations do |t|
      t.string :name
      t.text :body
      t.float :water, default: 0.0
      t.float :nutrients, default: 0.0
      t.integer :duration, default: 0

      t.references :user, foreign_key: true
      t.references :grow, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
