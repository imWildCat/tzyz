class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :receiver, null: false
      t.integer :n_type, limit: 3, null: false
      t.boolean :is_read, null: false, default: false, unsigned: true
      t.belongs_to :reason
      # t.belongs_to :related_user
      # t.belongs_to :related_topic
      # t.belongs_to :related_reply
      t.references :notifiable, polymorphic: true
      t.datetime :created_at, null: false
      t.datetime :deleted_at
    end

    add_index :notifications, :receiver_id
    add_index :notifications, :is_read
  end
end
