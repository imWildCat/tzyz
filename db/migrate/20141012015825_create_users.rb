class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # TODO: Find a way to implemnt unsigened column

      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      ## END

      t.string :nickname, null: false, limit: 8

      t.integer :group, null: false, limit: 2, default: 1
      t.integer :role, null: false, limit: 2, default: 1

      t.integer :fortune, null: false, default: 0, unsigned: true

      t.integer :topic_count, null: false, default: 0, unsigned: true
      t.integer :reply_count, null: false, default: 0, unsigned: true

      # t.string :remember_token

      t.timestamps

      # devise START

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false, unsigned: true
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false, unsigned: true # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      # devise END

    end

    ## Indexes
    # add_index :users, :email, unique: true
    # add_index :users, :nickname, unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true

  end
end
