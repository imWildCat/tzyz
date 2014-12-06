class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # TODO: Find a way to implemnt unsigened column

      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.string :nickname, null: false, limit: 8

      t.integer :group, null: false, limit: 2, default: 1
      t.integer :role, null: false, limit: 2, default: 1

      t.integer :fortune, null: false, default: 0, unsigned: true

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
