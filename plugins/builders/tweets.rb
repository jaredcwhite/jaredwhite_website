require "active_support/core_ext/array/wrap"

class Builders::Tweets < SiteBuilder
  def cache
    @@cache ||= Bridgetown::Cache.new("Tweets")
  end

  def build
    # tweet_ids:
    #   - 1574449797893066752
    #   - 1574410765750370306
    #   - 1562095589034078215

    # curl "https://api.twitter.com/2/tweets/1570055517489201156?expansions=author_id&user.fields=name,profile_image_url,url,username" -H "Authorization: Bearer AAAAAAAAAAAAAAAAAAAAA…"

    # {"data":{"id":"1570055517489201156","author_id":"105224601","text":"Calling all Rails developers!\n\nIf you were looking for a new job, what would you ABSOLUTELY want your potential employer to know?"},"includes":{"users":[{"profile_image_url":"https://pbs.twimg.com/profile_images/1469703667791982596/5-0pGyNV_normal.jpg","username":"joemasilotti","url":"https://t.co/AyaLIy13eY","name":"Joe Masilotti \uD83D\uDCD7","id":"105224601"}]}}

    # pseudo code
    hook :site, :post_read do
      tweet_ids = site.resources.map(&:data).map(&:tweet_ids).compact.flatten
      uncached_tweet_ids = []

      tweets = tweet_ids.map do |id|
        if cache.key?(id.to_s)
          cache[id.to_s]
        else
          uncached_tweet_ids << id
          nil
        end
      end.compact

      if (uncached_tweet_ids.length.positive?)
        resp = connection(headers: {
                "Authorization" => "Bearer #{ENV["TWITTER_V2_TOKEN"]}"
              }).get("https://api.twitter.com/2/tweets", {
                ids: uncached_tweet_ids.join(","),
                expansions: "author_id",
                "tweet.fields" => "created_at",
                "user.fields" => "name,profile_image_url,url,username"
              })

        data = resp.body

        Array.wrap(data[:data]).each do |tweet|
          tweet_payload = {
            data: tweet,
            users: data.includes.users
          }
          cache[tweet[:id].to_s] = tweet_payload
          tweets << tweet_payload
        end
      end

      tweets.each do |tweet|
        tweet = tweet.with_dot_access
        add_resource :tweets, "#{tweet.data.id}.md" do
          layout :tweet
          date Bridgetown::Utils.parse_date(tweet.data.created_at)
          content from: -> { tweet_links(tweet.data.text) }
          author tweet.users.find { _1.id == tweet.data.author_id }
        end
      end
    end
  end

  # thanks to https://andyatkinson.com/blog/2009/04/20/auto-linking-twitter-tweets-in-ruby-and-javascript
  def tweet_links(text)
    @helpers ||= Bridgetown::RubyTemplateView::Helpers.new(self, site)

    puts "old text", text
    auto_link(text, sanitize: false, scheme: "https")
      .gsub(/@(\w+)/, %Q{<a href="https://twitter.com/\\1">@\\1</a>})
      .gsub(/\#(\w+)/, %Q{<a href="https://twitter.com/hashtag/\\1">\#\\1</a>})
      .tap { puts "newtext", _1 }
  end

  # extracted out of https://github.com/tenderlove/rails_autolink/blob/master/lib/rails_autolink/helpers.rb
  def auto_link(text, *args, &block) #link = :all, html = {}, &block)
    return ''.html_safe if text.blank?

    options = args.size == 2 ? {} : args.extract_options! # this is necessary because the old auto_link API has a Hash as its last parameter
    unless args.empty?
      options[:link] = args[0] || :all
      options[:html] = args[1] || {}
    end
    options.reverse_merge!(:link => :all, :html => {})
    sanitize = (options[:sanitize] != false)
    sanitize_options = options[:sanitize_options] || {}
    text = conditional_sanitize(text, sanitize, sanitize_options).to_str
    case options[:link].to_sym
      when :all             then conditional_html_safe(auto_link_email_addresses(auto_link_urls(text, options[:html], options, &block), options[:html], &block), sanitize)
      when :email_addresses then conditional_html_safe(auto_link_email_addresses(text, options[:html], &block), sanitize)
      when :urls            then conditional_html_safe(auto_link_urls(text, options[:html], options, &block), sanitize)
    end
  end

  private

    AUTO_LINK_RE = %r{
        (?: ((?:ed2k|ftp|http|https|irc|mailto|news|gopher|nntp|telnet|webcal|xmpp|callto|feed|svn|urn|aim|rsync|tag|ssh|sftp|rtsp|afs|file):)// | www\. )
        [^\s<\u00A0"]+
      }ix

    # regexps for determining context, used high-volume
    AUTO_LINK_CRE = [/<[^>]+$/, /^[^>]*>/, /<a\b.*?>/i, /<\/a>/i]

    AUTO_EMAIL_LOCAL_RE = /[\w.!#\$%&'*\/=?^`{|}~+-]/
    AUTO_EMAIL_RE = /(?<!#{AUTO_EMAIL_LOCAL_RE})[\w.!#\$%+-]\.?#{AUTO_EMAIL_LOCAL_RE}*@[\w-]+(?:\.[\w-]+)+/

    BRACKETS = { ']' => '[', ')' => '(', '}' => '{' }

    WORD_PATTERN = RUBY_VERSION < '1.9' ? '\w' : '\p{Word}'

    # Turns all urls into clickable links.  If a block is given, each url
    # is yielded and the result is used as the link text.
    def auto_link_urls(text, html_options = {}, options = {})
      link_attributes = html_options.stringify_keys
      text.gsub(AUTO_LINK_RE) do
        scheme, href = $1, $&
        punctuation = []

        if auto_linked?($`, $')
          # do not change string; URL is already linked
          href
        else
          # don't include trailing punctuation character as part of the URL
          while href.sub!(/[^#{WORD_PATTERN}\/\-=;]$/, '')
            punctuation.push $&
            if opening = BRACKETS[punctuation.last] and href.scan(opening).size > href.scan(punctuation.last).size
              href << punctuation.pop
              break
            end
          end

          link_text = block_given?? yield(href) : href
          href = 'http://' + href unless scheme

          unless options[:sanitize] == false
            link_text = sanitize(link_text)
            href      = sanitize(href)
          end

          @helpers.link_to link_text, href, link_attributes
        end
      end
    end

    # Turns all email addresses into clickable links.  If a block is given,
    # each email is yielded and the result is used as the link text.
    def auto_link_email_addresses(text, html_options = {}, options = {})
      text.gsub(AUTO_EMAIL_RE) do
        text = $&

        if auto_linked?($`, $')
          text.html_safe
        else
          display_text = (block_given?) ? yield(text) : text

          unless options[:sanitize] == false
            text         = sanitize(text)
            display_text = sanitize(display_text) unless text == display_text
          end
          mail_to text, display_text, html_options
        end
      end
    end

    # Detects already linked context or position in the middle of a tag
    def auto_linked?(left, right)
      (left =~ AUTO_LINK_CRE[0] and right =~ AUTO_LINK_CRE[1]) or
        (left.rindex(AUTO_LINK_CRE[2]) and $' !~ AUTO_LINK_CRE[3])
    end

    def conditional_sanitize(target, condition, sanitize_options = {})
      condition ? sanitize(target, sanitize_options) : target
    end

    def conditional_html_safe(target, condition)
      condition ? target.html_safe : target
    end
end
