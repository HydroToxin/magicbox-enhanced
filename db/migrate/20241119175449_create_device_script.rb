class CreateDeviceScript < ActiveRecord::Migration[7.1]
  def change
    create_table :device_scripts do |t|
      t.string :name
      t.string :script_name
      t.string :description
      t.timestamps
    end
  end
end
