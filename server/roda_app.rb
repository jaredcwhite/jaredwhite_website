# Roda is a simple Rack-based framework with a flexible architecture based
# on the concept of a routing tree. Bridgetown uses it for its development
# server, but you can also run it in production for fast, dynamic applications.
#
# Learn more at: http://roda.jeremyevans.net

require_relative "../lib/roda/plugin/publisher_api"

class RodaApp < Bridgetown::Rack::Roda
  # Add Roda configuration here if needed

  plugin :bridgetown_ssr
  plugin :publisher_api

  route do |r|
    r.publisher_api

    r.bridgetown
  end
end
