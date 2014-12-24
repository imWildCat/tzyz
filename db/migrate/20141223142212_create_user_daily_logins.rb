class CreateUserDailyLogins < ActiveRecord::Migration
  def change
    create_table :user_daily_logins do |t|
      t.belongs_to :user, null: false, unsigned: true
      t.integer :day, null: false, unsigned: true
      t.integer :successive_days, null: false, unsigned: true, default: 1
      t.boolean :is_awarded, null: false, default: false
    end

    add_index :user_daily_logins, :user_id
    add_index :user_daily_logins, [:user_id, :day], unique: true
  end
end
