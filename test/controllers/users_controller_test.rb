require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "can show user's products and orders" do
    user_id = users(:lil).id
    session[:user_id] = user_id
    user = User.find(user_id)
    product = Product.find(products(:lil_product).id)
    retired = Product.find(products(:lil_product2).id)
    order = Order.find(2)
    order_item = OrderItem.find(order_items(:lil).id)
    get :show, { id: session[:user_id] }
    assert_response :success
    assert_template :show
    assert_equal assigns[:user], user
    # assert_equal assigns[:user].id, products(:lil_product).user_id
    assert_includes assigns(:products), product
    assert_includes assigns(:retired), retired
    assert_includes assigns(:orders), order
    assert_includes assigns(:order_items), order_item
  end

  test "will redirect and flash error if not logged in" do
    session[:user_id] = nil
    get :show, { id: 30 }
    assert_not_nil flash[:error]
    assert_response :redirect
    assert_redirected_to root_path
  end
end
