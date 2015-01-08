class UserSessionsController < ApplicationController

  skip_before_filter :require_login

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to(welcome_path)
    else
      flash[:danger] = 'Login failed'
      redirect_to(welcome_path)
    end
  end

  def destroy
    logout
    flash[:success] = 'You have been successfully logged out'
    redirect_to(welcome_path)
  end
end
