module HashtagsFilter
  def hashtags(input)
    tag_url_prefix = @context.registers[:site].config["url"].to_s + "/tag/"      
    input.gsub(/(^|\s|\>)#([a-z\d-]+)/i, "\\1<a href=\"#{tag_url_prefix}\\2\" class=\"hashtag\">#\\2</a>")
  end
end

Liquid::Template.register_filter(HashtagsFilter)
