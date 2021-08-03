class PublishedDateComponent < Bridgetown::Component
  attr_reader :resource

  def initialize(resource:)
    @resource = resource
  end
end
