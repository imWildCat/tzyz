class CreateFavoriteTopics < ActiveRecord::Migration
  def change
    create_table :favorite_topics do |t|
      t.belongs_to :user, null: false, unsigned: true
      t.belongs_to :topic, null: false, unsigned: true
    end

    add_index :favorite_topics, [:user_id, :topic_id], unique: true
    add_index :favorite_topics, :user_id
    add_index :favorite_topics, :topic_id
  end
end
