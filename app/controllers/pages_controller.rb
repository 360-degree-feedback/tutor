class PagesController < ApplicationController

  skip_before_filter :require_login, :authorised

  #add_breadcrumb "Home", :root_path

  def index
    if logged_in?
      @user = current_user
    end
  end
end
