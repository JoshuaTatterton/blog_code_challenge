class SubscriberMailer < ApplicationMailer
  
  default from: "#{Rails.application.secrets.active_email}"
  
  layout 'mailer'

  def notification_email(subscriber, article)
    @article = article
    @subscriber = subscriber
    
    mail(to: subscriber.email, subject: "New blog post - #{article.title}")
  end

end
