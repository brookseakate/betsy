require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
    @product = products(:order_test_product_1)
  end

  # NOTE: no index action
  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:reviews)
  # end

  test "should get new" do
    get :new, product_id: @product
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, product_id: @product, review: { product_id: 99, review: "lil is rad", rating: 5 }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  # NOTE: no show action (shown in products#show)
  # test "should show review" do
  #   get :show, id: @review
  #   assert_response :success
  # end

  # # NOTE: no edit action
  # test "should get edit" do
  #   get :edit, id: @review
  #   assert_response :success
  # end
  #
  # # NOTE: no update action
  # # test "should update review" do
  # #   patch :update, id: @review, review: {  }
  # #   assert_redirected_to review_path(assigns(:review))
  # # end
  #
  # # NOTE: no destroy action
  # test "should destroy review" do
  #   assert_difference('Review.count', -1) do
  #     delete :destroy, id: @review
  #   end
  #
  #   assert_redirected_to reviews_path
  # end
end
