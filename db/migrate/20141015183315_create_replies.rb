class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.timestamps
      t.belongs_to :topic, null: false, unsigned: true
      t.belongs_to :author, null: false, unsigned: true
      t.belongs_to :quoted_reply, null: true, unsigned: true
      t.text :content, null: false
      t.integer :position, null: false, unsigned: true
      t.integer :appreciations_count, null: false, default: 0, unsigned: true
      t.datetime :deleted_at
    end
    add_index :replies, :author_id
    add_index :replies, :deleted_at
  end


end
