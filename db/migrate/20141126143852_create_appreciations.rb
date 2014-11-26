class CreateAppreciations < ActiveRecord::Migration
  def change
    create_table :appreciations do |t|
      t.belongs_to :user, null: false, unsigned: true
      t.belongs_to :topic, null: false, unsigned: true
    end

    add_index :appreciations, [:user_id, :topic_id], unique: true
    add_index :appreciations, :user_id
    add_index :appreciations, :topic_id
  end
end
