class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :node_category_id, null: false, unsigned: true
      t.string :name, null: false, limit: 15
      t.string :slug, null: false, limit: 31
      t.string :decription, limit: 255
      t.boolean :need_login, null: false, default: false
      t.integer :min_group, null: false, limit: 3, default: 0, unsigned: true
      t.integer :min_role, null: false, limit: 3, default: 0, unsigned: true

      t.timestamps
    end

    add_index :nodes, :name, unique: true
    add_index :nodes, :slug, unique: true
  end
end
