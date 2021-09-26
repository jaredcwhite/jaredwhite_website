module ResourceFeedExtension
  CATEGORY_TYPES = %w(thoughts pictures links videos)

  def self.title_for_resource(resource)
    return resource.data.title if resource.is_a?(Bridgetown::GeneratedPage)

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

  def self.graph_description_for_resource(resource)
    if resource.data.subtitle
      resource.data.subtitle
    elsif resource.data.enclosure_mp3_url || resource.data.category == "videos"
      resource.data.description
    else
      resource.summary
    end
  end

  def self.formatted_date(date)
    date.strftime("%A, %B %-d, %Y @ %-I%P")
  end

  module LiquidResource
    def has_feed_title
      ResourceFeedExtension::CATEGORY_TYPES.include? data.category
    end

    def feed_title
      ResourceFeedExtension.title_for_resource self
    end

    def graph_description
      ResourceFeedExtension.graph_description_for_resource self
    end
  end

  module RubyResource
    def feed_title?
      ResourceFeedExtension::CATEGORY_TYPES.include? data.category
    end

    def feed_title
      ResourceFeedExtension.title_for_resource self
    end

    def graph_description
      ResourceFeedExtension.graph_description_for_resource self
    end
  end
end

Bridgetown::Resource.register_extension ResourceFeedExtension

# hack generated pages as well just to make views easier
Bridgetown::GeneratedPage.class_eval do
  def feed_title
    ResourceFeedExtension.title_for_resource self
  end

  def graph_description
    ResourceFeedExtension.graph_description_for_resource self
  end
end