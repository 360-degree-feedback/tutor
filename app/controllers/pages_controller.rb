class PagesController < ApplicationController

  include ApplicationHelper

  skip_before_filter :require_login, :authorised

  #add_breadcrumb "Home", :root_path

  def index
    if logged_in?
      @user = current_user
      @progress = progress(current_user)
    end
  end
end
