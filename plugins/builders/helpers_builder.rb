class HelpersBuilder < SiteBuilder
  def build
    helper "hashtags", :hashtags
    helper "translate_title", :translate_title
  end

  def hashtags(input, full_url: false)
    tag_url_prefix = "#{full_url ? site.config.url.to_s : ""}/tag/"      
    input.to_s.gsub(/(^|\s|\>)#([a-z\d-]+)/i) do
      "#{Regexp.last_match(1)}<a href=\"#{tag_url_prefix}#{Regexp.last_match(2).downcase}\" class=\"hashtag\">##{Regexp.last_match(2)}</a>"
    end.html_safe
  end

  def translate_title(input)
    segments = input.split
    %(#{I18n.t(segments[0])} #{segments[1..].join(" ")})
  end
end
