class OrdersController < ApplicationController
  def show # for paid order confirmation
    @order = Order.find(params[:id])
  end

  def edit # for "cart"/pending order (the update actions for this happen in OrderItemsController)
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def checkout # "edit"-like action for checkout/order confirmation when moving order to paid
    @order = Order.find(params[:id])
    render :checkout
  end

  def update # update action for checkout - order moving to paid
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
