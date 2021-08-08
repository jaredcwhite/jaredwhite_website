class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builders
end

Bridgetown::Resource::PermalinkProcessor.register_placeholder :ymd, ->(resource) do
  "#{resource.date.strftime("%Y")}#{resource.date.strftime("%m")}#{resource.date.strftime("%d")}"
end

Bridgetown::Resource::PermalinkProcessor.register_placeholder :y_m_d, ->(resource) do
  "#{resource.date.strftime("%Y")}-#{resource.date.strftime("%m")}-#{resource.date.strftime("%d")}"
end
