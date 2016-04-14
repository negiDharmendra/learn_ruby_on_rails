class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def show
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
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    def verify_password?
        @user.password!=@user.password_confirmation
    end

    private
    def set_user
        @user = User.find_by_id(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

end
