import "index.css"
import TumblrPhotos from "./tumblr_photos.js"

import SlIcon from '@shoelace-style/shoelace/dist/components/icon/icon';
import { registerIconLibrary } from '@shoelace-style/shoelace/dist/utilities/icon-library.js';

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

window.addEventListener("DOMContentLoaded", () => {
  document.body.addEventListener("click", (e) => {
    const sidebar = document.querySelector("responsive-sidebar")
    if (sidebar.getAttribute("open") === "" && !e.target.closest("responsive-sidebar")) {
      sidebar.removeAttribute("open")
      document.querySelector("main-content").removeAttribute("underneath")
    }
  })
})