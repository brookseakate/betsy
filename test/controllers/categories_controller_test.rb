require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should display all categories" do
   get :index
   assert_response :success
   assert_template :index
 end

  test "should display the products of one category" do
    get :show
    assert_response :success
    assert_template :show
  end

  #  assert_equal assigns(:categories), categories(:one)
 end
