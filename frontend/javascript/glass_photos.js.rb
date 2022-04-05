class GlassPhotos < HTMLElement
  def connected_callback()
    styles = <<~CSS
      glass-photos {
        grid-template-columns: 1fr 1fr;
        display: grid;
        gap: 15px;
        align-items: center;
      }

      glass-photos img {
        object-fit: cover;
        width: 100%;
        height: 6.5rem;
      }

      glass-photos a {
        transform: translateY(0px);
        transition: transform 0.33s;
      }
      glass-photos a:hover {
        transform: translateY(-7px);
      }
    CSS

    api_endpoint = self.get_attribute :src

    fetch(api_endpoint)
      .then { |response| response.json() }
      .then do |data|
        photos = data.map do |photo|
          <<~HTML
            <a href="#{photo['url']}" target="_blank">
              <img
                src="#{photo['photo_url']}"
                loading="lazy"
              />
            </a>
          HTML
        end
      self.inner_html = "<style>#{styles}</style>#{photos.join("")}"
    end
  end
end

custom_elements.define "glass-photos", GlassPhotos
