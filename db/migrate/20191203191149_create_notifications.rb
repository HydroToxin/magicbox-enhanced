class CreateNotifications < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.boolean :notify_email
      t.boolean :notify_push
      t.string :notifiable_type
      t.uuid :notifiable_uuid, null: true

      t.references :notifications, :notified, polymorphic: true, index: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
