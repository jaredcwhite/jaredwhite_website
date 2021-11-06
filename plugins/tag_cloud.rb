# Simplified code based on original concepts in jekyll-tagging gem
class Tagger < Bridgetown::Generator
  def generate(site)
    number_of_levels = 5
    site.data.tag_cloud = calculate_tag_cloud(site, number_of_levels)
  end

  def calculate_tag_cloud(site, num)
    range = 0
    tags = site.tags.map { |tag, posts|
      [tag.to_s, range < (size = posts.size) ? range = size : size]
    }

    range = 1..range
    tags.sort!.map! { |tag, size| [tag, quantile(range, size, num)] }
  end

  # extracted from nuggets gem
  def quantile(range, value, order = 100)
    value < range.first ? 1 : (
      value >= range.last ? order :
        (
          (value - range.first) / (
            (range.last - range.first) / order.to_f
          )
        ).to_i + 1
    )
  end
end

class TagCloud < Liquid::Tag
  def render(context)
    site = context.registers[:site]

    url_for_tag = ->(tag) { "/tag/#{Bridgetown::Utils.slugify(tag)}/" }
    
    site.data.tag_cloud.map do |tag, set|
      tag_link(tag, url_for_tag.(tag), :class => "set-#{set}")
    end.join(" ")
  end
  
  def tag_link(tag, url, html_opts)
    html_opts &&= " " << html_opts.map { |k, v| %Q{#{k}="#{v}"} }.join(" ")
    %Q{<a href="#{url}"#{html_opts}>#{tag}</a>}
  end
end

Liquid::Template.register_tag("tag_cloud", TagCloud)
