module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user
    puts @current_user
    @current_user ||= $current_user
  end

  def current_user?(user)
    user == current_user
  end
end
