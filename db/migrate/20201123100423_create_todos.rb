class CreateTodos < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :todos do |t|
      t.integer :todo_status, default: 0
      t.integer :renotify_every_minute
      t.datetime :date
      t.datetime :notified_date
      t.text :body
      t.boolean :notify_push, default: true
      t.uuid :uuid, null: false, default: -> { "gen_random_uuid()" }

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
