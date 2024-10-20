class CreateSamples < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :samples do |t|
      t.string :product_reference
      t.string :unit
      t.string :html_color
      t.string :category_name
      t.text :value

      t.references :data_type, foreign_key: true
      t.references :device, foreign_key: true

      t.timestamps
    end

    add_index :samples, :created_at, :algorithm => :concurrently

  end
end