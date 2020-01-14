require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { db:1, url: 'redis://127.0.0.1:6379/' }
end
Sidekiq.configure_client do |config|
  config.redis = { db:1, url: 'redis://127.0.0.1:6379/' }
end