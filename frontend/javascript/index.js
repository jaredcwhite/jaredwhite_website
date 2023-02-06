// Stylesheet entrypoint
import "@shoelace-style/shoelace/dist/themes/base.css"
import "index.css"

import smoothscroll from "smoothscroll-polyfill"
// kick off the polyfill!
smoothscroll.polyfill()

import "./toottown.js"

// Ruby2JS scripts
import "./shoelace.js.rb"
import "./dark_mode.js.rb"
import "./sidebar.js.rb"
import "./back_to_top.js.rb"
