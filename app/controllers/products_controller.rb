class productController < ApplicationController

    def index
      @products = Product.where(media_type: params[:media_type])
    end

    def new
      @product = Product.new
    end

    def show
      @product = Product.find(params[:id])
      @product.save
    end

    def create
      @product = Product.create
      if @product.save
        redirect_to products_path
      else
        render :new
      end
    end

    def destroy
      @product = Product.find(params[:id]).destroy
      redirect_to media_path
    end

    def edit
       @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to product_path(params[:id])
      else
        render :edit
      end
    end


    private

    def product_params
      params.require(:product).permit(:id, :user_id, :name, :price, :inventory, :description, :photo_url, :retired, :created_at, :updated_at )
    end
end
