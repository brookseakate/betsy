require 'test_helper'
class ProductFlowsTest < ActionDispatch::IntegrationTest
  test "can see the index page" do
    get "/products"
    assert_response :success
  end
end
