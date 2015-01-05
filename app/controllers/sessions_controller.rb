class SessionsController < ApplicationController

  skip_before_filter :require_login

  #layout  'login'

  def new
    # User already logged in
    if logged_in?
      redirect_to current_user
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      # Log in and direct to home page.
      log_in @user
      redirect_to lessons_path
    else
      # Error
      flash.now[:danger] = 'Invalid Email/Password Combination'
      render 'pages/index'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
