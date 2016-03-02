class ApplicationMailer < ActionMailer::Base

  include Resque::Mailer

  default from: "from@example.com"
  layout 'mailer'
  
end
