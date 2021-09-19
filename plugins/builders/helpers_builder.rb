class HelpersBuilder < SiteBuilder
  def build
    helper "hashtags", :hashtags
    helper "translate_title", :translate_title
  end

  def hashtags(input, full_url: false)
    tag_url_prefix = "#{full_url ? site.config.url.to_s : ""}/tag/"      
    input.to_s.gsub(/(^|\s|\>)#([a-z\d-]+)/i, "\\1<a href=\"#{tag_url_prefix}#{$2.downcase}\" class=\"hashtag\">#\\2</a>").html_safe
  end

  def translate_title(input)
    segments = input.split
    %(#{I18n.t(segments[0])} #{segments[1..].join(" ")})
  end
end
