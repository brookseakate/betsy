class SessionsController < ApplicationController
  # def logged_in?
  #   if session[:user_id]
  #   end
  # end
  # def index
  #   if session[:user_id].nil?
  #     redirect_to login_failure_path
  #   else
  #     @user = User.find(session[:user_id]) # < recalls the value set in a previous request
  #   end
  # end
  #
  # def login_failure
  #   render :login_failure
  # end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  # def new
  #   redirect_to '/auth/github'
  # end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect to login_failure_path unless auth_hash['uid']

    @user = User.find_by(id: auth_hash[:id], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save
    end

    # Save the user ID in the session
    session[:id] = @user.id

    redirect_to user_path(@user.id)
  end
end
