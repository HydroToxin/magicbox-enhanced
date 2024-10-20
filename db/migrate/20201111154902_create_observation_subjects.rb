class CreateObservationSubjects < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :observations_subjects do |t|
      t.references :observation, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
