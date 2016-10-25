REDIS = if Rails.env.development?
  Redis.new
else
  Redis.new(url: ENV[ENV["REDIS_PROVIDER"]])
end
