class PublisherViews::Posts < Bridgetown::Component
  attr_reader :r

  def initialize(request:)
    @r = request
    @site = Bridgetown::Current.site
  end

  def tags
    if site.collections.posts.resources.blank?
      site.data.site_taxonomies_hash = {}
      site.collections.posts.read
    end

    site.tags.keys.sort
  end

  def new_filename_template
    today = DateTime.now
    year = today.strftime("%Y")
    "#{r.params.fetch("category", "thoughts")}/#{year}/#{today.strftime("%Y-%m-%d")}-untitled.md"
  end
end
