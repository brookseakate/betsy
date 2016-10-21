class UsersController < ApplicationController
  before_action :require_login, except: [:index]
  # before_action :find_user, except: [:index]

  def show
    @products = @user.products.where(retired: false)
    @retired = @user.products.where(retired: true)
  end

  def new; end

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
