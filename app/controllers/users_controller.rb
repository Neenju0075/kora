class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers,:delete_follow]
  skip_before_action :authorize, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.where('softDelete = false')
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @question = @user.questions
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver_later
        format.html { redirect_to login_path, notice: 'User was successfully created. Login now!!!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_follow
    if params[:title].downcase == "following"
      @user.followed_users.each do |u|
        u.update_column(:softDelete, true)
      end
    elsif params[:title].downcase == "followers"
      @user.followers.each do |u|
        u.update_column(:softDelete, true)
      end
    end
    UserDeleteWorker.perform_async(params[:id],params[:title])
    respond_to do |format|
      format.html { redirect_to user_path, notice: 'Users was successfully destroyed!!' }
      format.json { head :no_content }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == get_current_user
      session.destroy
      session[:user_id] = nil
      $current_user = nil
      @user.destroy
      respond_to do |format|
        format.html { redirect_to login_path, notice: 'User was successfully destroyed and successfully logged out!!!!' }
        format.json { head :no_content }
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
    end
    end
  end

  def following
    @title = "Following"
    @users = @user.followed_users.where('softDelete = false')
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.where('softDelete = false')
    render 'show_follow'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email, :role)
    end
end
