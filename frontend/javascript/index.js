import "index.css"
import TumblrPhotos from "./tumblr_photos.js"

// Import all javascript files from src/_components
const componentsContext = require.context("bridgetownComponents", true, /.js$/)
componentsContext.keys().forEach(componentsContext)
