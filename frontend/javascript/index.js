import "index.css"
import TumblrPhotos from "./tumblr_photos.js"

// Import all javascript files from src/_components
const componentsContext = require.context("bridgetownComponents", true, /.js$/)
componentsContext.keys().forEach(componentsContext)

window.addEventListener("DOMContentLoaded", () => {
  let mouseMoved = false

  document.body.addEventListener("mousemove", () => {
    if (!mouseMoved) {
      mouseMoved = true
      setTimeout(() => document.querySelector("main > aside").classList.add("faded"), 1000)
    }
  })
})