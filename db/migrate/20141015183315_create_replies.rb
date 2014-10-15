class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.timestamps
      t.belongs_to :topic, null: false
      t.belongs_to :user, null: false
      t.text :content, null: false
    end
    add_index :replies, [:topic_id, :user_id]
  end


end
