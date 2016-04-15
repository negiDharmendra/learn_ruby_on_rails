class WelcomeController < ApplicationController
  def index
    @blogs = Blog.all
  end
end
