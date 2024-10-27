# frozen_string_literal: true

class CreateGrows < ActiveRecord::Migration[5.2]
  def change
    create_table :grows do |t|
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :substrate, default: 'soil'
      t.integer :flowering, defalut: 'autoflowering'
      t.integer :grow_status, null: false
      t.integer :number_of_subjects, default: 0
      t.integer :seedling_weeks, default: 0
      t.integer :vegging_weeks, default: 0
      t.integer :flowering_weeks, default: 0
      t.integer :flushing_weeks, default: 0
      t.integer :drying_weeks, default: 0
      t.integer :curing_weeks, default: 0
      t.integer :birth_type, default: 'from_seed'
      t.boolean :auto_update_status, default: true
      t.float :estimated_weight_by_square_meter, default: 0

      t.timestamps
    end
  end
end
