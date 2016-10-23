class ReviewsController < ApplicationController

  def index; end

  def new
    @review = Review.new
    @review.id = :product_id
    redirect_to products_path
  end
end
