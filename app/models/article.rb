class Article < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :comments
end
