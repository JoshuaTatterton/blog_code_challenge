class Article < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  
  has_many :comments
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

end
