require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should display all categories" do
   get :index
   assert_response :success
   assert_template :index
 end

  #  assert_equal assigns(:categories), categories(:one)
 end
