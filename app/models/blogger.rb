class Blogger < ActiveRecord::Base

  authenticates_with_sorcery!
  
  validates :email, presence: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }

  has_many :articles
  has_many :subscribers

end
