Bridgetown.configure do |config|
  init :dotenv
  init :ssr
  if ENV.fetch("TOOTTOWN_ACCESS_TOKEN", nil)
    init :toottown, access_token: ENV.fetch("TOOTTOWN_ACCESS_TOKEN"), instance_url: ENV.fetch("TOOTTOWN_INSTANCE_URL")
  end
end
