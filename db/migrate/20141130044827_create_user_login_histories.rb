class CreateUserLoginHistories < ActiveRecord::Migration
  def change
    create_table :user_login_histories do |t|

      t.timestamps null: false
    end
  end
end
