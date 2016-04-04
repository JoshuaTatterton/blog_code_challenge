class Subscriber < ActiveRecord::Base

  validates :email, presence: true
  
  belongs_to :blogger
  
  def send_email(article)
    SubscriberMailer.notification_email(self, article).deliver_now
  end

end
