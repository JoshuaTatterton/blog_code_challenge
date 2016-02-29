class ArticlesController < ApplicationController

  before_action :authenticate_user!, :except => [:index]
  
  def index
    @article = Article.new
    @articles = Article.all.reverse
  end

  def create
    article = Article.create(article_params)
    redirect_to articles_path
  end

  def article_params
    params.require(:article).permit(:content)
  end

end
