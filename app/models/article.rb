class Article < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  
  belongs_to :blogger, touch: true
  has_many :comments
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def markdown?
    option == "markdown"
  end

  def wysiwyg?
    option == "wysiwyg"
  end
end
