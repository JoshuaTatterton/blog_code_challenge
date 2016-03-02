class SubscriberMailer < ApplicationMailer
  
  

  default from: "#{Rails.application.secrets.active_email}"
  
  layout 'mailer'

  def instructions(subscriber, article)
    @subscriber = subscriber
    @article = article
    mail(to: @subscriber.email, subject: "New blog post - #{@article.title}")
  end

end
