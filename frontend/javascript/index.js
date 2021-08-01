import "index.css"


// Import all javascript files from src/_components
const componentsContext = require.context("bridgetownComponents", true, /.js$/)
componentsContext.keys().forEach(componentsContext)

console.info("Bridgetown is loaded!")


window.addEventListener("DOMContentLoaded", () => {
  let mouseMoved = false

  document.body.addEventListener("mousemove", () => {
    if (!mouseMoved) {
      mouseMoved = true
      setTimeout(() => document.querySelector("main > aside").classList.add("faded"), 1000)
    }
  })
})