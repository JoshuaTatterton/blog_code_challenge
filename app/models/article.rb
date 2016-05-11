class Article < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  
  belongs_to :blogger
  has_many :comments
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def markdown?
    option == "markdown"
  end

  def wysiwyg?
    option == "wysiwyg"
  end

  def search_content
    if wysiwyg?
      wysiwyg_content.downcase.gsub(" ", "") 
    else
      content.downcase.gsub(" ", "") 
    end
  end

  def search_title
    title.downcase.gsub(" ", "")
  end
end
