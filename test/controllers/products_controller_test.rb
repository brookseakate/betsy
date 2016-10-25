require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  test "should get the new form" do
    get :new
    assert_response :success
    assert_template :new
  end
  
  test "load show with given product" do
    get :show, { id: 1 }
    assert_response :success
    assert_template :show
  end

end
