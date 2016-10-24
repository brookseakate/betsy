class OrderItemsController < ApplicationController
  # # @TODO: remove #new action if unused; it will likely not be needed, as new OrderItems will be originating from a Product view
  # def new
  #   @order = Order.find(session[:cart_id])
  #   @order_item = @order.order_item.new
  # end

  def create # this action gets the order_id from the url/params (because of nested routing)
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.new(order_item_params)

    @product = @order_item.product

    if @order_item.save
      redirect_to edit_order_path(@order)
    else
      render 'products/show'
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order

    if @order_item.update(order_item_params)
      redirect_to edit_order_path(@order)
    else
      render 'orders/edit'
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order

    @order_item.destroy

    redirect_to edit_order_path(@order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :quantity)
  end
end
