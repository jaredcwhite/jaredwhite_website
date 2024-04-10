# Roda is a simple Rack-based framework with a flexible architecture based
# on the concept of a routing tree. Bridgetown uses it for its development
# server, but you can also run it in production for fast, dynamic applications.
#
# Learn more at: http://roda.jeremyevans.net

class RodaApp < Roda
  # Some Roda configuration is handled in the `config/initializers.rb` file.
  # But you can also add additional Roda configuration here if needed.
  plugin :bridgetown_server

  route(&:bridgetown)
end
