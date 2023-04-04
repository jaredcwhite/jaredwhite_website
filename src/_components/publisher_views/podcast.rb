class PublisherViews::Podcast < Bridgetown::Component
  attr_reader :r

  def initialize(request:)
    @r = request
    @site = Bridgetown::Current.site

    site.collections.podcast.read if site.collections.podcast.resources.blank?

    @new_number = site.collections.podcast.resources.first.data.number.to_i + 1
  end
end
