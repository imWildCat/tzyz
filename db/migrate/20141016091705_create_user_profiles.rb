class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles,
                 {
                     :id => false,
                     :primary_key => :user_id
                 } do |t|

      t.primary_key :user_id
      t.string :name
      t.string :city
      t.string :website
      t.string :weibo
      t.string :introduction

    end
  end
end
