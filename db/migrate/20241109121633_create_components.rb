class CreateComponents < ActiveRecord::Migration[7.1]
  def change
    create_table :components do |t|
      t.string :name, null: false
      t.string :component_type, null: false
      t.string :model
      t.string :version
      t.boolean :active
      t.boolean :microcontroller, default: false
      t.boolean :multiplexer, default: false
      t.string :description
      t.string :address
      t.decimal :voltage, precision: 5, scale: 2
      t.decimal :standby_ampere
      t.decimal :max_ampere
      t.decimal :watt
      t.decimal :power, precision: 8, scale: 4
      t.decimal :temperature, precision: 5, scale: 2

      t.timestamps
    end
  end
end
