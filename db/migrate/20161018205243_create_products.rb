class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, default: 0, null: false
      t.integer :user_id, null: false
      t.integer :inventory, default: 0, null: false
      t.string :description, null: false
      t.string :photo_url, null: false
      t.boolean :retired 
      t.timestamps null: false
    end
  end
end
