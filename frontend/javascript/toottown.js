class ToottownComment extends HTMLElement {
  // Declarative Shadow DOM Fallback
  connectedCallback() {
    const tmpl = this.querySelector("template[shadowrootmode]")
    if (tmpl) {
      this.attachShadow({ mode: tmpl.getAttribute("shadowrootmode") })
      this.shadowRoot.replaceChildren(tmpl.content.cloneNode(true))
      tmpl.remove()
    }
  }
}

if (!customElements.get("toottown-comment")) {
  customElements.define("toottown-comment", ToottownComment)
}

class ToottownCommentsLoader extends HTMLElement {
  connectedCallback() {
    setTimeout(() => {
      this.querySelector("button").addEventListener("click", async (event) => {
        const loadingPreamble = this.querySelector("template[name='loadingPreamble']").content.cloneNode(true)
        const commentsPreamble = this.querySelector("template[name='commentsPreamble']").content.cloneNode(true)
        const noThreadPreamble = this.querySelector("template[name='noThreadPreamble']").content.cloneNode(true)

        this.querySelector("p").replaceChildren(loadingPreamble)
        const resourceUrl = this.getAttribute("href")
        const data = { url: resourceUrl }
        if (this.hasAttribute("comments-hashtag")) {
          data.comments_hashtag = this.getAttribute("comments-hashtag")
        }
        const url = new URL(`https://${window.location.host}/toottown/comments`)
        for (let k in data) { url.searchParams.append(k, data[k]) }
  
        const resp = await fetch(url)
        const html = await resp.text()
  
        if (html.length > 0) {
          const parser = new DOMParser()
          const tmpl = parser.parseFromString(`<body>${html}</body>`, "text/html")
          this.parentElement.querySelector("toottown-comments").replaceWith(tmpl.body.firstChild)
  
          this.querySelector("p").replaceChildren(commentsPreamble)
          this.querySelector("p a[target]").href = this.parentElement.querySelector("toottown-comments").getAttribute("href")
        } else {
          this.querySelector("p").replaceChildren(noThreadPreamble)
        }
      })
    })
  }
}

if (!customElements.get("toottown-comments-loader")) {
  customElements.define("toottown-comments-loader", ToottownCommentsLoader)
}
