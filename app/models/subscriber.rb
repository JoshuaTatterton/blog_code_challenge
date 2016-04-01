class Subscriber < ActiveRecord::Base

  validates :email, presence: true
  
  def send_email(article)
    SubscriberMailer.notification_email(self, article).deliver_now
  end

end
