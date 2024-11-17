class CreateCircuits < ActiveRecord::Migration[7.1]
  def change
    create_table :circuits do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
