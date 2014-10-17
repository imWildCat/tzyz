class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.datetime :created_at, null: false
      t.integer :node_id, null: false
      t.integer :author_id, null: false
      t.integer :refresher_id, null: false
      t.string  :title, null: false, limit: 127
      t.integer :clicks_count, null: false, default: 0
      t.integer :replies_count, null: false, default: 0
      t.text    :content, null: false
      t.datetime :last_replied_at
    end
    add_index :topics, :author_id
    add_index :topics, :last_replied_at
  end
end