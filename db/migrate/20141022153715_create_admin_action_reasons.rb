class CreateAdminActionReasons < ActiveRecord::Migration
  def change
    create_table :admin_action_reasons do |t|
      t.string :description, limit: 63
    end
  end
end
