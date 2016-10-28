class DrinksController < ApplicationController
  def index
    @products =  Product.all
  end

  def show
    #IDEA: route templates related to user/products/order_items; etc
  end


end
