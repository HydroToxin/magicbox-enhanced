class CreateBatches < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :batches do |t|
      t.string :name
      t.float :total_weight
      t.float :batch_weight
      t.float :price_per_weight, default: 0
      t.float :batch_price, default: 0
      t.integer :batch_count
      t.integer :batch_type, default: 0

      t.references :grow, foreign_key: true
      t.references :harvest, foreign_key: true

      t.timestamps

    end
  end
end
