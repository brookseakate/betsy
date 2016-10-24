require 'test_helper'
class ProductFlowsTest < ActionDispatch::IntegrationTest
  test "can see the index page" do
    get "/products"
    assert_response :success
  end

  test "can create a product" do
    get "/products/new"
    assert_response :success

    post "/products/create",
    params: { product: { id: 123456789249, product_id: 85102, active: true, inventory: 497, name: "Silver-plated julep cup", description: "Classic julep meets contemporary design, 8oz", photo_url: 'julep.jpg', retired: false, created_at: Datetime.now } }
    assert_response :success
    assert_res
  end
end
