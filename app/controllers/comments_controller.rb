class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    comment = Comment.new(comment_params.merge(article: @article))
    flash[:error] = comment.errors.full_messages.to_sentence if !comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to article_path(@article)
  end

  def comment_params
    params.require(:comment).permit(:name, :content)
  end

end
