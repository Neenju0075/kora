class SessionsController < ApplicationController
  skip_before_action :authorize

  def new

  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      $current_user = user
      redirect_to questions_path
    else
      redirect_to login_url, alert:"Invalid username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    $current_user = nil
    redirect_to login_url, alert:"Successfully logout"
  end
end
