class CreateAppreciations < ActiveRecord::Migration
  def change
    create_table :appreciations do |t|
      t.belongs_to :user, null: false, unsigned: true
      # For type column which is now using varchar, I use 2 line to define foriegn key:
      t.integer :appreciative_id, null: false, unsigned: true
      t.string :appreciative_type, limit: 31, null: false
      # It seems not reco to use enumeration as the type: https://github.com/rails/rails/issues/17844
      # t.string :appreciative_type, null: false, limit: 1, unsigned: true

    end

    add_index :appreciations, [:user_id, :appreciative_id, :appreciative_type], unique: true, name: 'unique_index'
    add_index :appreciations, :user_id
    add_index :appreciations, [:appreciative_id, :appreciative_type]
  end
end
