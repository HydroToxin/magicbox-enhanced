class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.string :command
      t.string :description
      t.integer :delay
      t.integer :retries
      t.integer :duration, default: 0
  	  t.integer :device_type, default: 0

      t.references :condition_group, foreign_key: true

      t.timestamps
    end
  end
end
