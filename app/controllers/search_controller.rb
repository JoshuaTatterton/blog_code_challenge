class SearchController < ApplicationController

  def index
    @results = search(params[:search])
  end

  private

  def search(term)
    articles = Article.all
    terms = term.downcase.split(" ")
    puts terms

    articles.inject([]) do |memo, article|
      result = true
      if article.wysiwyg?
        content = article.wysiwyg_content.downcase.gsub(" ", "")
      else
        content = article.content.downcase.gsub(" ", "")
      end
      title = article.title.downcase.gsub(" ", "")
      puts content
      puts title
      terms.each do |t|
        if content.include?(t) || title.include?(t)
          result = true unless result == false
        else
          result = false
        end
      end

      if result
        memo << article 
      else
        memo
      end
    end
  end

end
