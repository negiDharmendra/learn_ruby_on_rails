class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:article_id])
    @blog.comments.create(params.require(:comment).permit(:commenter, :body))
    redirect_to article_path(@blog)
  end

  def destroy
    @blog  = Blog.find(params[:article_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@blog)

  end
end
