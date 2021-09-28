import "@shoelace-style/shoelace/dist/components/icon/icon.js"
import [ register_icon_library ], from: "@shoelace-style/shoelace/dist/utilities/icon-library.js"

# Register icons from the Remix collection (https://remixicon.com) for use by Shoelace
register_icon_library(
  :remixicon,
  resolver: -> (name) do
    match = name.match /^(.*?)\/(.*?)$/
    match[1] = match[1].char_at(0).upcase() + match[1].slice(1)
    "https://cdn.jsdelivr.net/npm/remixicon@2.5.0/icons/#{match[1]}/#{match[2]}.svg"
  end,
  mutator: -> svg { svg.set_attribute :fill, :current_color }
)
