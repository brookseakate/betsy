require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  setup do
    @order_item = order_items(:two)
  end

  test "should create order_item with correct Order id & Product id" do
    assert_difference('OrderItem.count') do
      post :create, { order_id: 2, order_item: { product_id: 22, quantity: 1 } }
    end

    assert_redirected_to edit_order_path(assigns(:order))

    assert_equal 22, assigns(:product).id
    assert_instance_of Product, assigns(:product)

    assert_equal 1, assigns(:order_item).quantity

    assert_equal 2, assigns(:order).id
    assert_instance_of Order, assigns(:order)
  end

  # @TODO - write this test
  #  test "should not be able to create order_item with quantity > product.inventory" do
  #   order_item = order_items(:one)
  #
  #   order_item.quantity = 10
  #
  #   assert_no_difference('OrderItem.count') do
  #     post :create, id: order_item.id, order_id: order_item.order_id, order_item: order_item
  #   end
  #
  #   assert_equal order_item_clone, @order_item
  #   assert_redirected_to edit_order_path(assigns(:order))
  # end

  test "should update order_item" do
    patch :update, id: @order_item, order_id: @order_item.order, order_item: { quantity: 3 }

    assert_redirected_to edit_order_path(assigns(:order_item).order)
    assert_equal 3, assigns(:order_item).quantity
  end

  test "should not be able to update order_item with quantity > product.inventory" do
    order_item_clone = @order_item.clone

    patch :update, id: @order_item, order_id: @order_item.order, order_item: { quantity: 100 }

    assert_equal order_item_clone, @order_item
    assert_redirected_to edit_order_path(assigns(:order))
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: @order_item, order_id: @order_item.order
    end

    assert_redirected_to edit_order_path(assigns(:order))
  end
end
