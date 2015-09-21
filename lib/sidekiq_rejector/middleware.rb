require 'sidekiq'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add SidekiqRejector::Middleware::Client
  end
end
