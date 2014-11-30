class CreateFortuneAlterations < ActiveRecord::Migration
  def change
    create_table :fortune_alterations do |t|
      t.belongs_to :user
      t.integer :quantity, null: false, default: 0
      t.integer :reason, limit: 3, null: false, unsigned: true
      t.integer :fortune_alterable_id, unsigned: true
      t.string :fortune_alterable_type, limit: 31

      t.datetime :created_at, null: false
    end

    add_index :fortune_alterations, :user_id
  end
end
