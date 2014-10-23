class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.timestamps
      t.belongs_to :topic, null: false
      t.belongs_to :author, null: false
      t.text :content, null: false
      t.datetime :deleted_at
    end
    add_index :replies, :author_id
    add_index :replies, :deleted_at
  end


end
