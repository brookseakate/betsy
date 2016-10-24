require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "Can create an Order" do
    order = Order.new
    assert order.valid?
  end

  test "#complete_checkout method updates Order status to 'paid'" do
    order = orders(:pending_two)
    assert_equal "pending", order.status
    order.complete_checkout
    order.save
    assert_not_equal "pending", order.status
    assert_equal "paid", order.status
  end

  test "#complete_checkout method updates inventory for associated products" do
    order = orders(:pending_two)

    # Create a hash of product_id & initial inventory
    begin_products_inventory = {}

    order.order_items.each do |order_item|
      product = order_item.product
      product_id = product.id
      begin_inventory = product.inventory
      begin_products_inventory[product_id] =  begin_inventory
    end

    order.complete_checkout
    order.save

    order.order_items.each do |order_item|
      product = order_item.product
      product_id = product.id
      purchase_quantity = order_item.quantity
      end_inventory = product.inventory

      begin_inventory = begin_products_inventory[product_id]

      assert_equal end_inventory, (begin_inventory - purchase_quantity)
    end
  end #complete_checkout updates product inventory test

  test "#complete_checkout updates the placed DateTime" do
    order = orders(:pending_two)
    orig_placed = order.placed

    order.complete_checkout
    order.save

    assert_not_nil order.placed
    assert_not_equal orig_placed, order.placed
  end

  test "Order may have one or more OrderItems" do
    order = orders(:pending_two)
    assert_not_nil order.order_items
  end
end
