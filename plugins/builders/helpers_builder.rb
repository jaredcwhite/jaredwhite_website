class HelpersBuilder < SiteBuilder
  def build
    helper "hashtags", :hashtags
  end

  def hashtags(input, full_url: false)
    tag_url_prefix = "#{full_url ? site.config.url.to_s : ""}/tag/"      
    input.to_s.gsub(/(^|\s|\>)#([a-z\d-]+)/i, "\\1<a href=\"#{tag_url_prefix}\\2\" class=\"hashtag\">#\\2</a>").html_safe
  end
end
