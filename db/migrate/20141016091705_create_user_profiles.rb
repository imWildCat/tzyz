class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles, {
        :id => false,
        :primary_key => :user_id
    } do |t|

      t.primary_key :user_id
      t.string :name, limit: 15
      t.string :city, limit: 31
      t.string :website, limit: 255
      t.string :weibo, limit: 63
      t.string :introduction, limit: 255

    end
  end
end
