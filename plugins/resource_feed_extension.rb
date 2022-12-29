# TODO: refactor all this stuff!

module ResourceFeedExtension
  CATEGORY_TYPES = %w(thoughts pictures links videos)

  def self.title_for_resource(resource, for_html: false) # rubocop:disable Metrics
    return resource.data.title if resource.is_a?(Bridgetown::GeneratedPage)

    case resource.data.category
    when "thoughts"
      if resource.has_model_title?
        resource.data.title
      else
        for_html ? resource.summary.truncate_words(15) : nil
      end
    when "pictures"
      for_html ? "Picture: #{resource.summary.truncate_words(15)}" : nil
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
    def has_model_title?
      @obj.has_model_title?
    end

    def has_feed_title
      ResourceFeedExtension::CATEGORY_TYPES.include? data.category
    end

    def feed_title
      ResourceFeedExtension.title_for_resource self
    end

    def html_title
      ResourceFeedExtension.title_for_resource self, for_html: true
    end

    def graph_description
      ResourceFeedExtension.graph_description_for_resource self
    end
  end

  module RubyResource
    def has_model_title?
      model.attributes.key?(:title)
    end

    def feed_title?
      ResourceFeedExtension::CATEGORY_TYPES.include? data.category
    end

    def feed_title
      ResourceFeedExtension.title_for_resource self
    end

    def html_title
      ResourceFeedExtension.title_for_resource self, for_html: true
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

  def html_title
    ResourceFeedExtension.title_for_resource self, for_html: true
  end

  def graph_description
    ResourceFeedExtension.graph_description_for_resource self
  end
end