class CreateSubjects < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :birth_type, default: 0

      t.references :room, foreign_key: true
      t.references :grow, foreign_key: true
      t.references :mother, foreign_key: { to_table: :subjects }
      t.references :strain, foreign_key: true

      t.timestamps
    end

    add_reference(:grows, :mother, foreign_key: { to_table: :subjects }, null: true, default: nil)

  end
end
