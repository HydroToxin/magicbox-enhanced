class CreateResourceData < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :resource_datas do |t|
      t.string :value

      t.references :resource, foreign_key: true
      t.references :observation, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
