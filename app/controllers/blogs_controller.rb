class BlogsController < ApplicationController
  attr_accessor :id

  def new

    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.new
    render 'new'
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.new(blog_params)
    if @blog.save
      redirect_to user_path(@user)
    else
      flash[:warning] = 'Something went wrong please try again'
      render 'new'
    end
  end

  def show
    get_blog
    render 'show'
  end

  def edit
    get_blog
    render 'blogs/edit'
  end

  def update
    get_blog
    @blog.versions.create(@blog.attributes.slice('title', 'content'))
    @blog.update blog_params
    redirect_to user_path (@user)
  end


  def destroy
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
    if logged_in? && !params[:user_id].nil?
      @user = User.find_by_id(params[:user_id])
      @blog = @user.blogs.find_by_id(params[:id])
    else
      @blog = Blog.find_by_id(params[:id])
    end
  end
end
