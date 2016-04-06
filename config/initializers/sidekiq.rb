require 'sidekiq'

Sidekiq.configure_client do |config|
  
  if ENV["REDISCLOUD_URL"]
    config.redis = { url: ENV["REDISCLOUD_URL"] }
  else
    config.redis = { url: "redis://localhost:6379/" }
  end

end

Sidekiq.configure_server do |config|
  if ENV["REDISCLOUD_URL"]
    config.redis = { url: ENV["REDISCLOUD_URL"] }
  else
    config.redis = { url: "redis://localhost:6379/" }
  end
end