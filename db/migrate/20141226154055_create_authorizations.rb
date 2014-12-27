class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.belongs_to :user
      t.string :provider, limit: 31
      t.string :uid, limit: 255
      t.string :image, limit: 255
      t.string :token, limit: 255
      t.string :secret, limit: 255
      t.string :profile_page, limit: 255

      t.timestamps null: false
    end
  end
end
