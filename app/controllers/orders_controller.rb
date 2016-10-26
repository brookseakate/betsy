class OrdersController < ApplicationController
  def cart
    # find Order object from session[:cart_id] & redirect to its edit page
    @order = Order.find(session[:cart_id])
    redirect_to edit_order_path(@order)
  end

  def show # for paid order confirmation
    @order = Order.find(params[:id])
    user_id = session[:user_id]
    @user = User.find(user_id)
  end

  def edit # for "cart"/pending order (the update actions for this happen in OrderItemsController)
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def checkout # "edit"-like action for checkout/order confirmation when moving order to paid
    @order = Order.find(params[:id])
  end

  def update # update action for CHECKOUT - order moving to paid
    @order = Order.find(params[:id])

    # Update inventory for purchased products, update order status to "paid"
    @order.complete_checkout

    # Clear the current cart
    session[:cart_id] = nil

    if @order.update(order_params)
      redirect_to order_path(@order)
    else
      render :checkout
    end
  end

  private

  def order_params
    params.require(:order).permit(:placed, :email, :mailing_address, :mailing_city, :mailing_state, :mailing_zip, :cc_holder_name, :cc_number, :exp, :cvv, :billing_zip, :status)
  end
end
