# frozen_string_literal: true

class CreateObservationResources < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :observation_resources do |t|
      t.string :value
      t.string :choice
      t.string :unit

      t.references :resource, foreign_key: true
      t.references :observation, foreign_key: true

      t.timestamps
    end
  end
end
