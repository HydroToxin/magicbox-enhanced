class AddAttributesToDevices < ActiveRecord::Migration[7.1]
  def change
    add_reference :devices, :component, foreign_key: true, null: true
    add_reference :devices, :device_script, foreign_key: true, null: true
  end
end
