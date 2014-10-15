class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # t.string :email, null: false
      t.string :nickname, null: false, limit: 8
      # t.string :password_digest, null: false

      t.integer :group_id, null: false, limit: 3, default: 1, unsigned: true
      t.integer :role_id, null: false, limit: 3, default: 1, unsigned: true

      t.integer :topics_count, null: false, default: 0, unsigned: true
      t.integer :replies_count, null: false, default: 0, unsigned: true

      t.string :remember_token

      t.timestamps
    end

    # Indexes
    # add_index :users, :email, unique: true
    # add_index :users, :nickname, unique: true

  end
end
