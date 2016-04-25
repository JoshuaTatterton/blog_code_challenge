class SearchController < ApplicationController

  include SearchHelper

  def index
    @hide = true

    @search_term = params[:search]
    @blogger_search = params[:blogger]

    @results = search(@search_term) if search_term?
  end

  private

  def search(term)
    articles = find_articles
    terms = term.downcase.split(" ")

    articles.inject([]) do |memo, article|
      content = article.search_content
      title = article.search_title

      result = params[:strict] ? 
        strict_search(title, content, terms) : slack_search(title, content, terms)

      memo << article if result != 0
      memo
    end
  end

  def strict_search(title, content, terms)
    terms.inject(1) do |memo2, t|
      memo2 *= 0 if !(title.include?(t) || content.include?(t))
      memo2
    end
  end

  def slack_search(title, content, terms)
    terms.inject(0) do |memo2, t|
      memo2 += 1 if !(title.include?(t) || content.include?(t))
      memo2
    end
  end

  def find_articles
    if blogger_search?
      return (blogger = Blogger.where("lower(username) = ?", 
                                      params[:blogger].downcase).first) ?
                                        blogger.articles.reverse : []
    else
      Article.all.reverse
    end
  end

end
