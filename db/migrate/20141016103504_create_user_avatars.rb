class CreateUserAvatars < ActiveRecord::Migration
  def change
    create_table :user_avatars, {
        :id => false,
        :primary_key => :owner_id
    } do |t|

      t.primary_key :owner_id
      t.boolean :is_enabled, null: false, default: true
      t.string :filename, limit: 31
      t.string :ttk_url
    end
  end
end
