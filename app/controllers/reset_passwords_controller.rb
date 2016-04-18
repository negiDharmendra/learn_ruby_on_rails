class ResetPasswordsController < ApplicationController
  def new
  end

  def edit
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticated?(:reset_password, params[:reset_password_token])
      render 'edit'
    else
      flash[:danger] = 'Invalid reset password token, try '
      redirect_to '/login'
    end
  end

  def create
    @user = User.find_by_email(params[:reset_password][:email])
    if @user
      @user.generate_reset_password_token
      UserMailer.reset_password(@user).deliver_now
      message = 'Your request for reset password is registered.'
      message += 'Please check your mail for further procedure'
      flash[:success_message] = message
      redirect_to '/'
    else
      flash[:danger] = 'Invalid email id'
      redirect_to '/login'
    end
  end

  def update
    @user = User.find_by_email(params[:reset_password][:email])
    if is_new_password_confirm
      @user.update_attribute(:password_digest, User.digest(params[:reset_password][:password]))
      log_in @user
      flash[:success_message] = 'Your password is updated successfully'
      redirect_to @user
    else
      flash[:danger] = 'Some thing went wrong please try again '
      redirect_to '/'
    end
  end

  def is_new_password_confirm
    new_password = params[:reset_password][:password]
    new_password_confirmation = params[:reset_password][:new_password_confirmation]
    new_password == new_password_confirmation
  end
end
