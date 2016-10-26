class ProductsController < ApplicationController

    before_action :require_login, except: [:index, :show, :category, :seller, :popular]

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def show
      @product = Product.find(params[:id])
      @order = Order.find(session[:cart_id])
      @order_item = @order.order_items.new(quantity: 1)
    end

    def create
      @product = @user.products.new(product_params) #EN: I think this will need to change to .new with params or @user.products.new to associate user_id with the product
      if @product.save
        redirect_to user_path(@user)
      else
        render :new
      end
    end

    def destroy
      @product = Product.find(params[:id])
      if @product.user_id != @user.id
        flash[:error] = "You cannot delete another seller's products! STOP BEING SHADY, YO"
        redirect_to root_path # might need to add a return here if doesn't work as expected
      else
        @product.destroy # make sure this doesn't execute if the condition is met above
      end
      redirect_to products_path
    end

    def edit
       @product = Product.find(params[:id])
       if @product.user_id != @user.id
         flash[:error] = "You cannot edit another seller's products! WHY ARE YOU TRYING? SHADY, YO"
         redirect_to root_path # might need to add a return here if doesn't work as expected
       end
    end

    def update # EN: do I need the same logic from edit?
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to product_path(params[:id])
      else
        render :edit
      end
    end

    def category
      @product =Product.where(name: :q)
    end

    def seller
      @products = Product.find(params[:user_id])
    end

    def popular
      @products = Product.order(rating: :desc)
    end

    def retire
      @product = Product.find(params[:id])
      @productstatus = params[:productstatus]
      if @product.user_id != @user.id
        flash[:error] = "You cannot delete another seller's products! STOP BEING SHADY, YO"
        redirect_to root_path
      end
      if @productstatus == "retire"
        @product.retire
      end
      if @productstatus == "activate"
        @product.activate
      end
      if @product.save
        redirect_to user_path(@user.id)
      end
    end

    private

    def product_params
      params.require(:product).permit(:id, :user_id, :name, :price, :inventory, :description, :photo_url, :retired, :created_at, :updated_at )
    end

    def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_login
      if current_user.nil?
        flash[:error] = "You must be logged in to make seller changes" #this only shows if you tell it to show
        redirect_to root_path
      end
    end
end
