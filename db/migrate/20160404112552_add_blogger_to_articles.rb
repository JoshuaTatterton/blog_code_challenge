class AddBloggerToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :blogger, index: true, foreign_key: true
  end
end
