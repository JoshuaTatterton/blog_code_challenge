class SearchController < ApplicationController

  include SearchHelper

  def index
    puts params[:search]
    @search_term = params[:search]
    @results = search(@search_term) if search_term?
  end

  private

  def search(term)
    articles = Article.all
    terms = term.downcase.split(" ")

    articles.inject([]) do |memo, article|
      content = article.search_content
      title = article.search_title

      result = terms.inject(1) do |memo2, t|
        memo2 *= 0 if !(title.include?(t) || content.include?(t))
        memo2
      end

      memo << article if result == 1
      memo
    end
  end

end
