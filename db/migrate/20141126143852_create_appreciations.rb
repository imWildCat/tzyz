class CreateAppreciations < ActiveRecord::Migration
  def change
    create_table :appreciations do |t|
      t.belongs_to :user, null: false, unsigned: true
      # For type column which is now using varchar, I use 2 line to define foriegn key:
      t.integer :appreciative_id, null: false, unsigned: true
      t.integer :appreciative_type, null: false, limit: 1, unsigned: true
      # Instead of:
      # t.references :appreciative, polymorphic: true, null: false, unsigned: true

    end

    add_index :appreciations, [:user_id, :appreciative_id, :appreciative_type], unique: true, name: 'unique_index'
    add_index :appreciations, :user_id
    add_index :appreciations, [:appreciative_id, :appreciative_type]
  end
end
