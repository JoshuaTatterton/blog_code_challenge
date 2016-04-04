class Blogger < ActiveRecord::Base

  authenticates_with_sorcery!
  
  validates :email, presence: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }

end
