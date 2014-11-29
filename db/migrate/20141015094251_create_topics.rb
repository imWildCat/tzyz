class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.integer :node_id, null: false, unsigned: true
      t.integer :author_id, null: false, unsigned: true
      t.integer :refresher_id, null: false, unsigned: true
      t.string  :title, null: false, limit: 127
      t.integer :clicks_count, null: false, default: 0, unsigned: true
      t.integer :replies_count, null: false, default: 0, unsigned: true
      t.integer :favorites_count, null: false, default: 0, unsigned: true
      t.integer :appreciations_count, null: false, default: 0, unsigned: true
      t.text    :content, null: false
      t.timestamps

    end
    add_index :topics, :author_id
  end
end