class VersionsController < ApplicationController

  def index

    get_version
    if (@blog.versions.count == 0)
      flash[:notice] = 'No copy has been created yet'
      redirect_to @user
    end
  else
    @version = Version.where(params[:blog_id])
  end

  def show
    get_version
    @version = @blog.versions.find_by_id(params[:id])
    render 'show'

  end

  private
  def get_version
    @user = User.find_by_id(params[:user_id])
    @blog = @user.blogs.find_by_id(params[:blog_id])
  end
end
