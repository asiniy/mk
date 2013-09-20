Sidekiq.configure_server do |config|
  config.redis = { namespace: 'mk' }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'mk' }
end
