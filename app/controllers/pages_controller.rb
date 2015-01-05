class PagesController < ApplicationController


  #add_breadcrumb "Home", :root_path

  def index
    if logged_in?
      @user = current_user
    end
  end
end
