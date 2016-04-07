class AddOptionToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :option, :string
  end
end
