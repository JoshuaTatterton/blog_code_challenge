class CommentsController < ApplicationController

  def create
    blogger = Blogger.find(params[:blogger_id])
    article = Article.find(params[:article_id])
    comment = article.comments.new(comment_params)

    flash[:error] = comment.errors.full_messages.to_sentence if !comment.save

    redirect_to blogger_article_path(blogger, article)
  end

  def destroy
    blogger = Blogger.find(params[:blogger_id])
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:id])
    
    comment.destroy

    redirect_to blogger_article_path(blogger, article)
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content)
  end

end
