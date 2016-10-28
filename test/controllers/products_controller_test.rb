require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  test "1. should get the index page" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "2. load show with given product" do
    get :show, { id: 1 }
    assert_response :success
    assert_template :show
  end

  test "3. user can add a new product" do
    session[:user_id] = users(:lil).id
    get :new
    assert_response :success
    assert_template :new
  end

  test "4. guests cannot add a product" do
    get :new
    assert_response 302
    assert_redirected_to root_path
  end

  test "6. not everyone should be able to create a new product" do
    product_params = {product: {id: 2, inventory: 80, description: "the best", user_id: nil}}
    total = Product.all.count
    post :create, product_params
    assert_equal total, Product.all.count
    assert_response :redirect
    assert_redirected_to root_path

  end

  test "7. should create a new user product" do
    session[:user_id] = users(:lil).id
    product_params = {product: { id: 567, name: "beveled coup", inventory: 80, description: "the worst best thing"}}
    assert_difference('Product.count', 1) do
      post :create, product_params
    end
    assert_redirected_to user_path(users(:lil).id)
  end

    test "8. Allow user to edit her/their own products" do
      session[:user_id] = users(:lil).id
      product_params = {id: products(:lil_product).id}
      get :edit, product_params
      assert_response :success
      assert_template :edit
    end

    test "9. Allow user to edit their and only their products" do
      session[:user_id] = users(:lil).id
      product_params = {id: products(:one).id}
      get :edit, product_params
      assert_response :redirect
      assert_redirected_to root_path
    end

  test "10. user should destroy a product if they want to" do
    assert_difference('Product.count', -1) do
      session[:user_id] = users(:lil).id
      delete :destroy, {id: products(:lil_product2).id}
      assert :success
    end
  end

  test "11. should create a new user product with categories" do
    session[:user_id] = users(:lil).id
    product_params = {product: { id: 567, name: "beveled coup", inventory: 80, description: "the worst best thing", categories_products: {first: categories(:one).id, second: categories(:two).id, third: categories(:three).id}, categories: {name: "New cat name for test"}}}
    assert_difference('Product.count', 1) do
      post :create, product_params
    end
    assert_redirected_to user_path(users(:lil).id)
  end
end
