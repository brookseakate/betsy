class OrderItemsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @order_item = @order.order_item.new(order_item_params)

    @product = @order_item.product

    if @order_item.save
      redirect_to edit_order_path(@order)
    else
      render 'product/show'
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order

    if @order_item.update(order_item_params)
      redirect_to edit_order_path(@order)
    else
      render 'order/edit'
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
