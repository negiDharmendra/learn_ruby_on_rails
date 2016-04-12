class SessionsController < ApplicationController
    def new

    end


    def authentication
        user = User.find_by_email(params[:users][:email])
        if user && user.authenticate(params[:users][:password])
            redirect_to user
        else
            flash[:danger] = 'Invalid email/password combination' # Not quite right!
            redirect_to users_path
        end
    end
end
