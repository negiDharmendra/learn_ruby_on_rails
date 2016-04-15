class BlogsController < ApplicationController
  def create
    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.create(params.require(:blog).permit(:title, :content))
    redirect_to user_path(@user)
  end

  def show
  end

  def new
    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.new
  end

  def destroy
    # require 'pry'; binding.pry
    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.find_by(id: params[:id])
    @blog.destroy
    redirect_to user_path(@user)
  end
end
