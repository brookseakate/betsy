class OrdersController < ApplicationController
  # def new
  #   @order_id = session[:cart_id]
  #   @order = Order.find(@order_id)
  # end

  def show; end

  def edit # for cart
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update # for cart
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:placed, :email, :mailing_address, :mailing_city, :mailing_state, :mailing_zip, :cc_holder_name, :cc_number, :exp, :cvv, :billing_zip, :status)
  end
end
