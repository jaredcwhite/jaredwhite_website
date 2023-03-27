class PublisherViews::Posts < Bridgetown::Component
  def initialize(request:)
    @site = Bridgetown::Current.site
  end

  def tags
    if site.collections.posts.resources.blank?
      site.data.site_taxonomies_hash = {}
      site.collections.posts.read
    end

    site.tags.keys.sort
  end
end
