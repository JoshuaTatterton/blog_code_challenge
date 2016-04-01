class ArticlesController < ApplicationController

  def index
    @article = Article.new
    @articles = Article.all.reverse
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
    @comment = Comment.new
  end

  def create
    article = Article.new(article_params)

    if article.save
      Subscriber.all.each { |sub| sub.send_email(article) }
    else
      flash[:error] = article.errors.full_messages.to_sentence
    end

    redirect_to articles_path
  end

  def update
    session[:return_to] ||= request.referer

    article = Article.find(params[:id])
    article.update(article_params)

    redirect_to session.delete(:return_to)
  end

  def destroy
    article = Article.find(params[:id])
    
    article.destroy
    
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
