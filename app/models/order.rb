class Order < ActiveRecord::Base
  has_many :order_items

  # def self.status_options
  #   return ["pending", "paid", "complete", "cancelled"]
  # end # self.status_options


  def complete_checkout
    # Change the order state from "pending" to "paid"
    self.status = "paid"

    # Reduces the inventory quantity for purchased products
    self.order_items.each do |order_item|
      product = order_item.product
      product.inventory -= order_item.quantity
      product.save
    end

    # Add "placed" time/date to Order when purchase is complete
    self.placed = DateTime.now
  end
end
