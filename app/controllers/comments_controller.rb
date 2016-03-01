class CommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    comment = Comment.create(comment_params.merge(article: article))
    redirect_to article_path(article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to articles_path(@article)
  end

  def comment_params
    params.require(:comment).permit(:name, :content)
  end

end
