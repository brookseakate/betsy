require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "Cannot create OrderItem without an Order association" do
    order_item = OrderItem.new(quantity: 3, product_id: 2)

    assert_not order_item.valid?
  end

  test "Cannot create OrderItem without a Product association" do
    order_item = OrderItem.new(quantity: 3, order_id: 2)

    assert_not order_item.valid?
  end

  test "Cannote create an OrderItem without a quantity that is: integer greater than 0" do
    # no quantity
    order_item_one = OrderItem.new(product_id: 1, order_id: 2)
    assert_not order_item_one.valid?

    # Float quantity
    order_item_one = OrderItem.new(product_id: 1, order_id: 2, quantity: 3.3)
    assert_not order_item_one.valid?

    # Quantity 0
    order_item_one = OrderItem.new(product_id: 1, order_id: 2, quantity: 0)
    assert_not order_item_one.valid?
  end

  test "Can create an OrderItem with valid data, it has correct associations" do
    order_item = OrderItem.new(product_id: 1, order_id: 2, quantity: 3)

    assert order_item.valid?

    order_item.save

    assert_equal order_item.product.id, 1
    assert_instance_of Product, order_item.product

    assert_equal order_item.order.id, 2
    assert_instance_of Order, order_item.order
  end

  test "#subtotal method correctly calculates subtotal" do
    order_item = order_items(:three)
    # quantity: 15
    # product_id: 1
    # price: 999999

    assert_equal 14999985, order_item.subtotal
  end
end
