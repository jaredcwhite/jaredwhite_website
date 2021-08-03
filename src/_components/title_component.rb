class TitleComponent < Bridgetown::Component
  def initialize(title:, url:, h_level:)
    @title, @url, @h_level = title, url, h_level
  end
end
