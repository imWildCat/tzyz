class CreateNodeCategories < ActiveRecord::Migration
  def change
    create_table :node_categories do |t|
      t.string :name, null: false, limit: 15
      t.string :slug, null: false, limit: 31

      t.timestamps
    end

    add_index :node_categories, :name, unique: true
    add_index :node_categories, :slug, unique: true
  end
end
