class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize


  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url notice: "Login needed!!"
    end
  end

  def get_current_user
    User.find_by(id:session[:user_id])
  end

  helper_method :admin?
  def admin?
    get_current_user.role == "admin"
  end

end
