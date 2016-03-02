class Subscriber < ActiveRecord::Base

  validates :email, presence: true
  
  def send_email(article)
    SubscriberMailer.instructions(self, article).deliver
  end

end
