HealthGraph.configure do |config|
  config.client_id = ENV['RUNKEEPER_CLIENT_ID']
  config.client_secret = ENV['RUNKEEPER_CLIENT_SECRET']
  # config.authorization_redirect_url = [PAGE TO REDIRECT THE USER TO AFTER AUTH]
end
