module ResourceFeedTitleExtension
  CATEGORY_TYPES = %w(thoughts pictures links videos)

  def self.title_for_resource(resource)
    case resource.data.category
    when "thoughts"
      "Thought for #{formatted_date(resource.date)}"
    when "pictures"
      "Picture for #{formatted_date(resource.date)}"
    when "links"
      "Link: #{resource.data.title}"
    when "videos"
      "Video: #{resource.data.title}"
    else
      resource.data.title
    end
  end

  def self.formatted_date(date)
    date.strftime("%A, %B %-d, %Y at %-I:%M %p")
  end

  module LiquidResource
    def has_feed_title
      ResourceFeedTitleExtension::CATEGORY_TYPES.include? self.data.category
    end

    def feed_title
      ResourceTitleExtension.title_for_resource self
    end
  end

  module RubyResource
    def feed_title?
      ResourceFeedTitleExtension::CATEGORY_TYPES.include? self.data.category
    end

    def feed_title
      ResourceTitleExtension.title_for_resource self
    end
  end
end

Bridgetown::Resource.register_extension ResourceFeedTitleExtension
