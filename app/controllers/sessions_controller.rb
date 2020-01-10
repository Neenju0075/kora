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
      flash[:notice]  = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    $current_user = nil
    flash[:notice] ="Successfully logged out!!!!"
    redirect_to login_url
  end
end
