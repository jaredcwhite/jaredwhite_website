import "index.css"
import TumblrPhotos from "./tumblr_photos.js"

import SlIcon from '@shoelace-style/shoelace/dist/components/icon/icon';
import { registerIconLibrary } from '@shoelace-style/shoelace/dist/utilities/icon-library.js';

// Register icons from the Remix collection (https://remixicon.com) for use by Shoelace
registerIconLibrary('remixicon', {
  resolver: name => {
    const match = name.match(/^(.*?)\/(.*?)(-(fill))?$/);
    match[1] = match[1].charAt(0).toUpperCase() + match[1].slice(1);
    return `https://cdn.jsdelivr.net/npm/remixicon@2.5.0/icons/${match[1]}/${match[2]}${match[3] || '-line'}.svg`;
  },
  mutator: svg => svg.setAttribute('fill', 'currentColor')
});

// Import all javascript files from src/_components
const componentsContext = require.context("bridgetownComponents", true, /.js$/)
componentsContext.keys().forEach(componentsContext)

const activateDarkMode = () => {
  document.body.classList.toggle("dark-mode", true)
}
if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
  activateDarkMode()
}

window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", e => e.matches && activateDarkMode() )

// Handle responsive sidebar taps outside the sidebar
window.addEventListener("DOMContentLoaded", () => {
  document.querySelector("#nav-tab").addEventListener("click", (e) => {
    const tab = e.currentTarget
    if (tab.parentNode.getAttribute("open") === "") {
      tab.parentNode.removeAttribute("open")
      document.querySelector("main-content").removeAttribute("underneath")
    } else {
      tab.parentNode.setAttribute("open", "")
      document.querySelector("main-content").setAttribute("underneath", "")
    }
  })
  document.body.addEventListener("click", (e) => {
    const sidebar = document.querySelector("responsive-sidebar")
    if (sidebar.getAttribute("open") === "" && !e.target.closest("responsive-sidebar")) {
      sidebar.removeAttribute("open")
      document.querySelector("main-content").removeAttribute("underneath")
    }
  })
})