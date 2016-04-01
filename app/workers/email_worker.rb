class EmailWorker
  include Sidekiq::Worker

  def perform(article_id)
    Subscriber.all.each { |sub| sub.send_email(Article.find(article_id)) }
  end
end