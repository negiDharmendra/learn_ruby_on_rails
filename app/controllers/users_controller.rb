class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      redirect_to '/'
    else
      flash[:danger] = 'You are not logged in. Try to log in first'
      redirect_to '/login'
    end
  end


  def show
    if logged_in?
      render 'show'
    else
      flash[:danger] = 'You are not logged in. Try to log in first'
      redirect_to '/login'
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      UserMailer.sample_email(@user).deliver_now
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private
  def set_user
    @user = User.find_by_id(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
