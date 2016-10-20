class OrdersController < ApplicationController

  def new
    @cart_id = session[:cart_id]
  end
end
