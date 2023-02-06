Bridgetown.configure do |config|
  init :dotenv
  init :ssr

  ENV["REDIS_URL"] = "redis://#{ENV['REDIS_HOSTPORT']}" if ENV["REDIS_HOSTPORT"]
  init :toottown, access_token: ENV.fetch("TOOTTOWN_ACCESS_TOKEN"), instance_url: ENV.fetch("TOOTTOWN_INSTANCE_URL")
end
