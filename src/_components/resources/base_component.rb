module Resources
  class BaseComponent < Bridgetown::Component
    attr_reader :resource, :h_level, :show_thumbnail

    class << self
      def component_for_resource(resource)
        case resource.data.category
        when "articles"
          ArticleComponent
        when "pictures"
          PictureComponent
        when "links"
          LinkComponent
        when "thoughts"
          ThoughtComponent
        when "videos"
          VideoComponent
        end
      end
    end

    def initialize(resource:, h_level: :h2, show_thumbnail: false)
      @resource, @h_level, @show_thumbnail = resource, h_level, show_thumbnail
    end
  end
end
