class BlogsController < ApplicationController
  def new
    @blog = Blog.new
  end

  def index
    @blog = Blog.all
  end

  def edit
    @blog = Blog.find_by_id(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      redirect_to @blog
    else
      render 'new'
    end
  end

  def update
    @blog = Blog.find_by_id(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render 'edit'
    end
  end

  def destroy
    @blog  = Blog.find_by_id(params[:id])
    @blog.destroy
    
    redirect_to blog_path
  end
  def show
    @blog = Blog.find_by_id(params[:id])
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :text)
  end

end
