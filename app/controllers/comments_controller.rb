class CommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    comment = article.comments.new(comment_params)

    flash[:error] = comment.errors.full_messages.to_sentence if !comment.save

    redirect_to article_path(article)
  end

  def destroy
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:id])
    
    comment.destroy

    redirect_to article_path(article)
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content)
  end

end
