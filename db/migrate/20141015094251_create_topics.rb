class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.integer :node_id, null: false, unsigned: true
      t.integer :author_id, null: false, unsigned: true
      t.integer :status, null: false, default: 1
      t.integer :refresher_id, null: false, unsigned: true
      t.string  :title, null: false, limit: 127
      t.integer :click_count, null: false, default: 0, unsigned: true
      t.integer :reply_count, null: false, default: 0, unsigned: true
      t.integer :favorite_count, null: false, default: 0, unsigned: true
      t.integer :appreciation_count, null: false, default: 0, unsigned: true
      t.text    :content, null: false
      t.timestamps null: false
      t.datetime :priority, null: false

    end
    add_index :topics, :author_id
    add_index :topics, :priority
    add_index :topics, :status
  end
end