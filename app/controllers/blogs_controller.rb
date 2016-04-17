class BlogsController < ApplicationController
  attr_accessor :id

  def new
    # require 'pry'; binding.pry
    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.new
    render 'new'
  end

  def create
    # require 'pry'; binding.pry
    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.create(blog_params)
    redirect_to user_path(@user)
  end

  def show
    # require 'pry'; binding.pry
    get_blog
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
    # require 'pry'; binding.pry
    if logged_in? && !params[:user_id].nil?
      @user = User.find_by_id(params[:user_id])
      @blog = @user.blogs.find_by_id(params[:id])
    else
      @blog = Blog.find_by_id(params[:id])
    end
  end
end
