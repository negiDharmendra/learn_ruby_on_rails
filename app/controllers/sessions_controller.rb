class SessionsController < ApplicationController
    def new

    end


    def create
        user = User.find_by_email(params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            redirect_to user
        else
            flash[:danger] = 'Invalid email/password combination' # Not quite right!
            redirect_to user_path
        end
    end
end
