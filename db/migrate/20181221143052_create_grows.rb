class CreateGrows < ActiveRecord::Migration[5.2]
  def change
    create_table :grows do |t|
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :substrate
      t.integer :flowering
      t.integer :grow_status
      t.integer :number_of_subjects
      t.integer :seedling_weeks
      t.integer :vegging_weeks
      t.integer :flowering_weeks
      t.integer :flushing_weeks
      t.integer :drying_weeks
      t.integer :curing_weeks
      t.integer :birth_type, default: 0
      t.boolean :auto_update_status, default: true
      t.float :estimated_weight_by_square_meter, default: 0

      t.timestamps
    end
  end
end
