HealthGraph.configure do |config|
  config.client_id = ENV["RUNKEEPER_CLIENT_ID"]
  config.client_secret = ENV["RUNKEEPER_CLIENT_SECRET"]
end
