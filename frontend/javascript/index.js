// Stylesheet entrypoint
import "@shoelace-style/shoelace/dist/themes/base.css"
import "index.css"

import smoothscroll from "smoothscroll-polyfill"
// kick off the polyfill!
smoothscroll.polyfill()

// Ruby2JS scripts
import "./tumblr_photos.js.rb"
import "./shoelace.js.rb"
import "./dark_mode.js.rb"
import "./sidebar.js.rb"
import "./back_to_top.js.rb"
