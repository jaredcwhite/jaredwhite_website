class PublisherViews::NowEntries < Bridgetown::Component
  attr_reader :r

  def initialize(request:)
    @r = request
  end

  def new_filename_template
    today = DateTime.now
    "#{today.strftime("%Y-%m-%d")}-now.md"
  end
end
