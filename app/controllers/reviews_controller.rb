class ReviewsController < ApplicationController

  def index; end

  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new
    # @review = Review.new
    # @review.id = :product_id
    # redirect_to product_path(@product)
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)

    if @review.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :review, :rating)
  end
end
