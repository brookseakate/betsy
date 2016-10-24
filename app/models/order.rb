class Order < ActiveRecord::Base
  has_many :order_items

  # @TODO - write validation for:
  # An Order must have one or more Order Items

  # @TODO - remove if unused
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

    # This method does not save to database! That needs to be done where called (in controller action, etc.)
  end

  def order_total #totals all the items and its subtotals yes
    total = 0
    self.order_items.each do |order_item|
      total += order_item.subtotal
    end
    return total
  end

  def last_digits(number)
    number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
  end

  def mask(number)
    "#{'X' * (number.to_s.length - 4)} - #{last_digits(number)}"
  end

end
