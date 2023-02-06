class Builders::Permalinks < SiteBuilder
  def build
    permalink_placeholder :ymd do |resource|
      "#{resource.date.strftime("%Y")}#{resource.date.strftime("%m")}#{resource.date.strftime("%d")}"
    end

    permalink_placeholder :y_m_d do |resource|
      "#{resource.date.strftime("%Y")}-#{resource.date.strftime("%m")}-#{resource.date.strftime("%d")}"
    end
  end
end
