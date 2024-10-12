class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :shortname
      t.string :choices, array: true, default: []
      t.string :units, array: true, default: []
      t.text :description

      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
