class AddWysiwygContentToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :wysiwyg_content, :text
  end
end
