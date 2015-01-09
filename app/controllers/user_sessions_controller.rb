class UserSessionsController < ApplicationController

  skip_before_filter :require_login

  add_breadcrumb 'Home', :root_path

  def new
    add_breadcrumb 'Login', login_path

    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = 'You have been successfully logged in'
      redirect_to(root_path)
    else
      flash[:danger] = 'Login failed'
      redirect_to(root_path)
    end
  end

  def destroy
    logout
    flash[:success] = 'You have been successfully logged out'
    redirect_to(root_path)
  end
end
