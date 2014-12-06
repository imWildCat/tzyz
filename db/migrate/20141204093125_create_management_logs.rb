class CreateManagementLogs < ActiveRecord::Migration
  def change
    create_table :management_logs do |t|
      t.belongs_to :user, null: false, unsigned: true
      t.integer :manageable_id, unsigned: true
      t.string :manageable_type, limit: 31
      t.string :field_changed, limit: 31
      t.integer :action_type, limit: 3, unsigned: true, null: false
      t.string :old_value
      t.string :new_value

      t.datetime :created_at, null: false
    end
  end
end
