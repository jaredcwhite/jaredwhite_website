import SlIcon, from: "@shoelace-style/shoelace/dist/components/icon/icon.js"
import [ register_icon_library ], from: "@shoelace-style/shoelace/dist/utilities/icon-library.js"

# Register icons from the Remix collection (https://remixicon.com) for use by Shoelace
register_icon_library(
  :remixicon,
  resolver: -> (name) do
    match = name.match /^(.*?)\/(.*?)(-(fill))?$/
    match[1] = match[1].char_at(0).upcase() + match[1].slice(1)
    "https://cdn.jsdelivr.net/npm/remixicon@2.5.0/icons/#{match[1]}/#{match[2]}#{match[3] || '-line'}.svg"
  end,
  mutator: -> svg { svg.set_attribute :fill, :current_color }
)

# Import all javascript files from src/_components
#const componentsContext = require.context("bridgetownComponents", true, /.js$/)
#componentsContext.keys().forEach(componentsContext)
