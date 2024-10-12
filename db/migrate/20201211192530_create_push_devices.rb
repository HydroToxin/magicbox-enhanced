class CreatePushDevices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :push_devices do |t|
      t.references :device, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
