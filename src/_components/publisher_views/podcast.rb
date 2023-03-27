class PublisherViews::Podcast < Bridgetown::Component
  attr_reader :r

  def initialize(request:)
    @r = request
    @site = Bridgetown::Current.site
  end
end
