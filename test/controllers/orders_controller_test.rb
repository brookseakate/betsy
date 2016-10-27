require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @pending_order = orders(:pending_one)
    @paid_order = orders(:paid_order)
  end

  test "cart should show correct Order page using session[:cart_id] value" do
    session[:cart_id] = 1

    get :cart
    assert_redirected_to edit_order_path(1)
    assert_equal assigns(:order), Order.find(1)
  end

  test "should show confirmation order view" do
    get :confirmation, id: @paid_order
    assert_response :success
    assert_template :confirmation
  end

  test "should get edit" do
    get :edit, id: @pending_order
    assert_response :success
    assert_template :edit
  end

  test "should get checkout" do
    get :checkout, id: @pending_order
    assert_response :success
    assert_template :checkout
  end


  test "should update order" do
    patch :update, id: @pending_order, order: { email: "a@b.com", cc_number: 11111 }

    assert_response :redirect
    assert_redirected_to confirmation_path(assigns(:order))
    assert_equal "a@b.com", assigns(:order).email
    assert_equal 11111, assigns(:order).cc_number
  end

  test "update should complete checkout" do
    patch :update, id: @pending_order, order: { email: "a@b.com", cc_number: 11111 }

    assert_equal "paid", assigns(:order).status
    assert_not_nil assigns(:order).placed
  end

  test "update should clear session[:cart_id]" do
    session[:cart_id] = 55555
    patch :update, id: @pending_order, order: { email: "a@b.com", cc_number: 11111 }

    assert_nil session[:cart_id]
  end

  test "TEST 8: should display the unique items of a user in a unique order" do
    session[:user_id] = users(:lil)
    get :show, {id: orders(:lil_order).id }
    assert_template 'orders/show'
    assert_response :success

    assigns(:matched_items)

    # assert_equal user.order_items[0].order_id, orders(:lil_order).id

    assert_equal assigns(:user).order_items.count, assigns(:matched_items).count

    assert_includes orders(:lil_order).order_items, assigns(:matched_items).first

  end

  # test "match the correct order items to the order for the authorized user" do
  #   get :show, {}
  #   # find a way to parse out the order item for the current signed in user
  #   #I want to get the user's order items, and only get the order items that match the order_id
  #   the_orders_id = orders(:lil_order).id
  #   user = users(:lil)
  #   matched_items = [] #collects all matching order items
  #    user.order_items.each do |item|
  #       if item.order_id == the_orders_id
  #         matched_items <<  item
  #       end
  #         matched_items
  #     end
  #   assert_equal user.order_items[0].order_id, orders(:lil_order).id
  #   #
  #   assert_equal user.order_items.count, matched_items.count
  #
  #   assert_includes orders(:lil_order).order_items, matched_items.first
  #
  #   # assert_equal assigns(:user), users(:lil)
  #   end
end
