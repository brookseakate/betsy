class UsersController < ApplicationController
  before_action :require_login, except: [:index]
  # before_action :find_user, except: [:index]

  def show
    @status = params[:orderstatus]

    case @status
    when nil, "all"
      @orders = @user.orders
    when "pending"
      @orders = @user.orders_by_status("pending")
    when "paid"
      @orders = @user.orders_by_status("paid")
    when "completed"
      @orders = @user.orders_by_status("completed")
    when "cancelled"
      @orders = @user.orders_by_status("cancelled")
    end

    @products = @user.products.where(retired: false)
    @retired = @user.products.where(retired: true)

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
