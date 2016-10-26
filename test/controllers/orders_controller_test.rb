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

  test "should show paid order" do
    get :show, id: @paid_order
    assert_response :success
    assert_template :show
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
    assert_redirected_to order_path(assigns(:order))
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

  # test "TEST 8: should display the unique items of a user in a unique order" do
  #   get :show, {id: orders(:lil_order).id }
  #   assert_template 'orders/show'
  #   assert_response :success
  #
  #
  # end
end
