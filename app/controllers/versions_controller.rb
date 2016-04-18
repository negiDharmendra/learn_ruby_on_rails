class VersionsController < ApplicationController

  def show
    get_version
       render 'show'

  end

  private
  def get_version
    @blog = Blog.find_by_id(params[:blog_id])
    @version = @blog.versions.find_by_id(params[:id])
  end
end
