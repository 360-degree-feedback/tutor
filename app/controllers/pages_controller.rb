class PagesController < ApplicationController

  include ApplicationHelper

  skip_before_filter :require_login, :authorised

  add_breadcrumb 'Home', :root_path

  def index
    if logged_in?
      @user = current_user
      @progress = progress(current_user)

      if current_user.admin
        @tests = Test.last(5).reverse
      end
    end

  end

  def error
    add_breadcrumb 'Error', error_path
  end

  def congratulations
    add_breadcrumb 'Congratulations', congratulations_path
  end

end
