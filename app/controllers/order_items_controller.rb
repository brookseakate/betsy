class OrderItemsController < ApplicationController
  def create # this action gets the order_id from the url/params (because of nested routing)
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.new(order_item_params)

    @product = @order_item.product

    # if !@order_item.sufficient_stock?
    #   flash[:insufficient_stock] = "There are only #{@product.inventory} units of #{@product.name} left in stock. Please reduce your order quantity and resubmit."
    # end

    if @order_item.save
      redirect_to edit_order_path(@order)
    else
      render 'products/show'
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @product = @order_item.product

    @order_items = @order.order_items # required for rendering orders/edit page within this action

    # @TODO: display errors correctly if order_items does not update
    
    # if @order_item.sufficient_stock? != true
    #   flash[:insufficient_stock] = "There are only #{@product.inventory} units of #{@product.name} left in stock. Please reduce your order quantity and resubmit."
    #   redirect_to edit_order_path(@order) and return
    #   # redirect_to 'orders/edit' and return
    # else

      if @order_item.update(order_item_params)
        redirect_to edit_order_path(@order)
      else
        # render 'orders/edit'
        redirect_to edit_order_path(@order)
      end
    # end
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
