class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        flash[:danger] = 'Your account is not activated. Please check your mail to activate your email'
        redirect_to '/'
        return
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out current_user if logged_in?

    redirect_to '/'
  end
end
