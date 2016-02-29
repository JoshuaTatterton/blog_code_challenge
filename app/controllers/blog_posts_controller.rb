class BlogPostsController < ApplicationController
  def index
    @articles = Article.all.reverse
  end
end
