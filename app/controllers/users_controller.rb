class UsersController < ApplicationController
  before_action :require_login, except: [:index]
  # before_action :find_user, except: [:index]

  def show
    if params[:orderstatus].nil?
      @orders = @user.orders
    end

    if params[:orderstatus] == "pending"
      @orders = @user.orders_by_status("pending")
    end

    if params[:orderstatus] == "paid"
      @orders = @user.orders_by_status("paid")
    end

    @products = @user.products.where(retired: false)
    @retired = @user.products.where(retired: true)


    # @order_items = @user.order_items
    # @orders_pending = @user.orders_by_status("pending")
    # @orders_paid = @user.orders_by_status("paid")
    # @orders_complete = @user.orders_by_status("complete")
    # @orders_cancelled = @user.orders_by_status("cancelled")
  end
  #
  def filter
    if params[:orderstatus] == "pending"
      @order = @user.orders_by_status("pending")
    end

    if params[:orderstatus] == "paid"
      @order = @user.orders_by_status("paid")
    end

    redirect_to user_path(@user)

    # if @task.save
    #   redirect_to tasks_path
    # else
    #   render :edit
    # end
    # @orders = @user.orders
    # @order_items = @user.order_items
    # @orders_pending = @user.orders_by_status("pending")
    # @orders_paid = @user.orders_by_status("paid")
    # @orders_complete = @user.orders_by_status("complete")
    # @orders_cancelled = @user.orders_by_status("cancelled")
  end

  # def new; end
  #
  # def create; end
  #
  # def edit; end
  #
  # def update; end

  private

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
