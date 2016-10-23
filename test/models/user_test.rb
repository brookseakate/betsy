require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should be able to retrieve all orders associated with user" do
    lil = users(:lil).id
    user = User.find(lil)
    product = Product.create(user_id: lil, name: "test product", price: 999)
    item = OrderItem.create(order_id: 2,
    product_id: product.id, quantity: 2)
    order = Order.find(2)
    assert_includes user.orders, order
  end

  test "should retrieve all revenues for the user" do
    lil = users(:lil).id
    user = User.find(lil)
    product = Product.find(99)
    item = OrderItem.find_by(order_id: 88)
    order = Order.find(88)
    assert_equal user.revenues, item.subtotal
  end
end
