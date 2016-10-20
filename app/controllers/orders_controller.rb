class OrdersController < ApplicationController
  # def new
  #   @order_id = session[:cart_id]
  #   @order = Order.find(@order_id)
  # end

  def show; end

  def edit
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
end
