require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  test "1. should get the homepage" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "2. load show with given product" do
    get :show, { id: 1 }
    assert_response :success
    assert_template :show
  end

  test "3. not everyone should be able to create a new product" do
    product_params = {product: {id: 2, inventory: 80, description: "the best"}}
    post :create, product_params
    assert_response :redirect
    assert_redirected_to products_path
  end

  test "4. should create a product" do
    current_count = Product.all.count
    product_params = { product: { name: "martini shaker", inventory: "2", description: "silver-plated shaker" }}
    post :create, product_params
    assert_equal current_count + 1, Product.all.count
  end

  test "5. user should get to edit" do
    @session = true
    get :edit, { id: products(:one).id }
    assert_response :success
  end

  #
  # test "can't update a product without an id" do
  #   product_params = {product: {id: products(:one).id }}
  #   patch :update, product_params
  #   assert_redirected_to 'edit_product_path'
  # end
  #
  # test "should update with id and user id" do
  #   product_params = { product: {id: 208, user_id: 102 }}
  #   patch :update, product_params
  #   assert_redirected_to product_path.product_params
  # end


  test "should destroy" do
    assert_difference('Product.count', -1) do
      delete :destroy, {id: products(:one).id}
      assert :success
    end
    assert_redirected_to products_path
  end

end
