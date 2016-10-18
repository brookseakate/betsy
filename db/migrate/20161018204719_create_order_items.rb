class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :quantity, default: 0, null: false
      t.integer :order_id, null: false
      t.integer :product_id, null: false

      t.timestamps null: false
    end
  end
end
