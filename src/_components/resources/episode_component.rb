module Resources
  class EpisodeComponent < BaseComponent
    def embed? = resource.data.embed_url.nil?.!
  end
end