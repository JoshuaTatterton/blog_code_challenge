class ArticlesController < ApplicationController

  def index
    @article = Article.new
    @articles = Article.all.reverse
    @blogger = Blogger.find(params[:blogger_id])
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
    @comment = Comment.new
  end

  def create
    article = Article.new(article_params)

    if article.save
      EmailWorker.perform_async(article.id)
    else
      flash[:error] = article.errors.full_messages.to_sentence
    end

    redirect_to articles_path
  end

  def update
    article = Article.find(params[:id])
    article.update(article_params)

    redirect_to :back
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
