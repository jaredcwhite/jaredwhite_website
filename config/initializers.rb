Bridgetown.configure do |config|
  init :dotenv
  init :ssr
  init :toottown, access_token: ENV.fetch("TOOTTOWN_ACCESS_TOKEN"), instance_url: ENV.fetch("TOOTTOWN_INSTANCE_URL")

  config.autoload_paths << {
    path: "models",
    eager: true
  }
end
