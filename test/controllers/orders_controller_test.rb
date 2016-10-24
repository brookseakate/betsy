require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:pending_one)
  end

  test "cart should show correct Order page using session[:cart_id] value" do
    session[:cart_id] = 1

    get :cart
    assert_redirected_to edit_order_path(1)
    assert_equal assigns(:order), Order.find(1)
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
    assert_template :show
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
    assert_template :edit
  end

  test "should get checkout" do
    get :checkout, id: @order
    assert_response :success
    assert_template :checkout
  end


  test "should update order" do
    patch :update, id: @order, order: { email: "a@b.com", cc_number: 11111 }

    assert_response :redirect
    assert_redirected_to order_path(assigns(:order))
    assert_equal "a@b.com", assigns(:order).email
    assert_equal 11111, assigns(:order).cc_number
  end

  test "update should complete checkout" do
    patch :update, id: @order, order: { email: "a@b.com", cc_number: 11111 }

    assert_equal "paid", assigns(:order).status
    assert_not_nil assigns(:order).placed
  end

  test "update should clear session[:cart_id]" do
    session[:cart_id] = 55555
    patch :update, id: @order, order: { email: "a@b.com", cc_number: 11111 }

    assert_nil session[:cart_id]
  end
end
