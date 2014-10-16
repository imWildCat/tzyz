class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :receiver_id, unsigned: true
      t.integer :sender_id, unsigned: true
      t.boolean :is_read, default: false
      t.string :content, null: false, limit: 511
      t.datetime :created_at, null: false
      t.datetime :deleted_at

    end

    add_index :messages, :receiver_id
    add_index :messages, :sender_id
  end
end
