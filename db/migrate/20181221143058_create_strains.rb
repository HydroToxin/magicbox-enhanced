class CreateStrains < ActiveRecord::Migration[5.2]
  def change
    create_table :strains do |t|
      t.string :name
      t.string :description
      t.string :breeder
      t.string :location
      t.string :terpenes
      t.text :effects, array: true, default: [], using: "(string_to_array(effects, ','))"
      t.text :ailments, array: true, default: [], using: "(string_to_array(ailments, ','))"
      t.text :flavors, array: true, default: [], using: "(string_to_array(flavors, ','))"
      t.integer :strain_type
      t.integer :crosses

      t.timestamps
    end
  end
end
