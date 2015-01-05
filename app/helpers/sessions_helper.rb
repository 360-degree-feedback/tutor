module SessionsHelper

  # Log user in
  def log_in(user)
    session[:user_id] = user.id
  end

  # Check if the user is logged in
  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  # Returns true if logged in
  def logged_in?
    !current_user.nil?
  end

  # Log user out
  def log_out
    session.delete :user_id
    @current_user = nil
  end

end
