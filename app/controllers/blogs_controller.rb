class BlogsController < ApplicationController
  attr_accessor :id

  def new
    get_blog
  end

  def create
    @user = User.find_by_id(params[:user_id])
    blog_params
    redirect_to user_path(@user)
  end

  def show
    # require 'pry'; binding.pry
    get_blog
    render 'show'
  end

  def show_for_all
    require 'pry'; binding.pry
    @blog = Blog.find_by_id(params[:id])
    render 'show'
  end

  def edit
    get_blog
    render 'blogs/edit'
  end

  def update
    get_blog
    @blog.update blog_params
    redirect_to user_path (@user)
  end


  def destroy
    # require 'pry'; binding.pry
    get_blog
    @blog.destroy
    redirect_to user_path(@user)
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  private
  def get_blog
    if logged_in?
      @user = User.find_by_id(params[:user_id])
      @blog = @user.blogs.find_by_id(params[:id])
    else
      @blog = Blog.find_by_id(params[:id])
    end
  end
end
