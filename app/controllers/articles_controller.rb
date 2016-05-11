class ArticlesController < ApplicationController

  def index
    @blogger = Blogger.find(params[:blogger_id])

    @article = @blogger.articles.new
    @articles = @blogger.articles.all.reverse
  end

  def show
    @blogger = Blogger.find(params[:blogger_id])
    @article = Article.find(params[:id])
    @comments = @article.comments.all
    @articles = sample_articles(@blogger, @article)
    @comment = @article.comments.new
  end

  def create
    blogger = Blogger.find(params[:blogger_id])
    article = blogger.articles.new(article_params)

    if article.save
      EmailWorker.perform_async(article.id)
    else
      flash[:error] = article.errors.full_messages.to_sentence
    end

    redirect_to blogger_articles_path(blogger)
  end

  def update
    article = Article.find(params[:id])
    article.update(article_params)

    redirect_to :back
  end

  def destroy
    blogger = Blogger.find(params[:blogger_id])
    article = Article.find(params[:id])
    
    article.destroy
    
    redirect_to blogger_articles_path(blogger)
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :option, :wysiwyg_content)
  end

  def sample_articles(blogger, current_article)
    alt = []

    if blogger.articles.length > 5
      puts "big"
      while alt.length < 5
        a = blogger.articles.sample
        if !(alt.include?(a)) && !(a == current_article)
          alt.push(a)
        end
      end
    else

      blogger.articles.length.times do |i|
        a = blogger.articles[i]
        
        if !(a == current_article)
          alt << (a)
        end
      end
    end 
    
    alt
  end

end
