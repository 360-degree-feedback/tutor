class UsersController < ApplicationController

  skip_before_filter :require_login, :only => [:create, :activate]
  before_filter :authorised, except: [:activate]
  before_action :set_user, only: [:edit, :update, :destroy, :show]

  add_breadcrumb 'Home', :root_path

  def index
    add_breadcrumb 'Users', users_path
    @users = User.all
  end

  def new
    add_breadcrumb 'Users', users_path
    add_breadcrumb 'New', new_user_path

    @user = User.new
  end

  def show
    redirect_to edit_user_path(@user)
  end

  def edit
    add_breadcrumb 'Users', users_path
    add_breadcrumb 'Edit', edit_user_path(@user)
  end

  def create
    @user = User.new(user_params)

      if @user.save
          redirect_to users_path
          flash[:success] = 'User was successfully created.'
      else
        flash[:danger] = 'Error: User was not created'
        redirect_to new_user_path
      end
  end

  def update
      if @user.update(user_params)
       redirect_to @user, notice: 'User was successfully updated.'
      else
        flash[:danger] = 'Error: User was not updated'
        redirect_to edit_user_path(@user)
      end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      flash[:success] = 'Account successfully activated'
      redirect_to(welcome_path)
    else
      not_authenticated
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :admin, :activation_state, :activation_token, :activation_token_expires_at)
    end

end
