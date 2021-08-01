# Simplified code pulled from jekyll-tagging gem
class Tagger < Bridgetown::Generator
  def generate(site)
    add_tag_cloud(site)
  end
  
  def add_tag_cloud(site, num = 5)
    site.data["tag_cloud"] = calculate_tag_cloud(site, num)
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
    value < range.first ? 1 : value >= range.last ? order :
      ((value - range.first) / ((range.last - range.first) / order.to_f)).to_i + 1
  end
end

module MySite
  class TagCloudTag < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      
      site.data["tag_cloud"].map { |tag, set|
        _tag_link(tag, _tag_url(tag), :class => "set-#{set}")
      }.join(' ')
    end
    
    def _tag_link(tag, url, html_opts)
      html_opts &&= ' ' << html_opts.map { |k, v| %Q{#{k}="#{v}"} }.join(' ')
      %Q{<a href="#{url}"#{html_opts}>#{tag}</a>}
    end
  
    def _tag_url(tag)
      "/tag/" + Bridgetown::Utils.slugify(tag) + "/"
    end
  end
end

Liquid::Template.register_tag('tag_cloud', MySite::TagCloudTag)
