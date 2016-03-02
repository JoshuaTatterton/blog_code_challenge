class Subscriber < ActiveRecord::Base

  def send_email(article)
    SubscriberMailer.instructions(self, article).deliver
  end

end
