class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :paid
      t.datetime :placed
      t.string :email, null: false
      t.string :mailing_address
      t.string :cc_holder_name
      t.integer :cc_number
      t.date :exp
      t.integer :cvv
      t.timestamps null: false
    end
  end
end
