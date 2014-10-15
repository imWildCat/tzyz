class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.timestamps
      t.integer :user_id, null: false
      t.string  :title, null: false, limit: 127
      t.integer :click_count, null: false, default: 0
      t.integer :reply_count, null: false, default: 0
      t.text    :content, null: false
      t.timestamp :last_modified_at
    end
    add_index :topics, [:user_id, :last_modified_at]
  end
end