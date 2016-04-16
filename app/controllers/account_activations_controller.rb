class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      flash[:success_message] = 'Account activated! now you can log in to your account'
      redirect_to '/login'
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
