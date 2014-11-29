class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles, {
                                   :id => false,
                                   :primary_key => :owner_id
                               } do |t|

      # t.primary_key :owner_id
      t.primary_key :owner_id
      t.string :name, limit: 15
      t.boolean :gender
      t.string :headline, limit: 63
      t.string :field, limit: 3, limit: 15
      t.string :company, limit: 63
      t.string :university, limit: 63
      t.string :city, limit: 31
      t.string :website, limit: 127
      t.string :email, limit: 127
      t.integer :qq, unsigned: true
      t.string :weibo, limit: 63
      t.string :wechat, limit: 31
      t.string :linkedin, limit: 127
      t.string :zhihu, limit: 31
      t.string :douban, limit: 31
      t.string :renren, limit: 31
      t.string :introduction, limit: 255

    end
  end
end
