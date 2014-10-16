class CreateUserAvatars < ActiveRecord::Migration
  def change
    create_table :user_avatars, {
        :id => false,
        :primary_key => :user_id
    } do |t|

      t.boolean :is_enabled, null: false, default: true
      t.string :ttk_url

    end
  end
end
