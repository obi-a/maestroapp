redis_config = {
  url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}",
}

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
