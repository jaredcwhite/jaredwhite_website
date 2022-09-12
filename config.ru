# This file is used by Rack-based servers during the Bridgetown boot process.

require "bridgetown-core/rack/boot"

Bridgetown::Rack.boot
#require 'localhost/authority' if Bridgetown.env.development?

run RodaApp.freeze.app # see server/roda_app.rb
