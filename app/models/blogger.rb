class Blogger < ActiveRecord::Base

  authenticates_with_sorcery!

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }

  has_many :articles
  has_many :subscribers

  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

end
