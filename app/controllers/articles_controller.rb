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
    @article = Article.create(article_params)
    Subscriber.all.each { |sub| sub.send_email(@article) }
    redirect_to articles_path
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to articles_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
