class CreateUserLoginHistories < ActiveRecord::Migration
  def change
    create_table :user_login_histories do |t|
      t.belongs_to :user, null: false, unsigned: true
      t.string :ip, limit: 16, null: false
      t.datetime :created_at, null: false
    end

    add_index :user_login_histories, :user_id
  end
end
