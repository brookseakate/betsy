class ThinkieDrinkieController < ApplicationController
  def index
    @products = Product.all
  end
end
