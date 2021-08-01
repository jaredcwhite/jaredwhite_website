class TumblrPhotos extends HTMLElement {
  connectedCallback() {
    const style = `
      <style>
        tumblr-photos {
          grid-template-columns: 1fr 1fr;
          display: grid;
          gap: 15px;
          align-items: center;
        }

        tumblr-photos img {
          object-fit: cover;
          width: 100%;
          height: 6.5rem;
        }

        tumblr-photos a {
          transform: translateY(0px);
          transition: transform 0.33s;
        }
        tumblr-photos a:hover {
          transform: translateY(-7px);
        }
      </style>
    `

    fetch(this.getAttribute("src")).then(response => response.json()).then(data => {
      const photos = data.map(photo => {
        return `
          <a href="${photo.url}" target="_blank">
            <img
              src="${photo.photo_url}"
              loading="lazy"
            />
          </a>
        `
      })

      this.innerHTML = style + photos.join("")
    })
  }
}

customElements.define("tumblr-photos", TumblrPhotos)

export default TumblrPhotos