require "bridgetown"

Bridgetown.load_tasks

#
# Standard set of tasks, which you can customize if you wish:
#
desc "Build the Bridgetown site for deployment"
task :deploy => [:clean, "frontend:build"] do
  Bridgetown::Commands::Build.start
end

desc "Build the site in a test environment"
task :test do
  ENV["BRIDGETOWN_ENV"] = "test"
  Bridgetown::Commands::Build.start
end

desc "Runs the clean command"
task :clean do
  Bridgetown::Commands::Clean.start
end

namespace :frontend do
  desc "Build the frontend with Webpack for deployment"
  task :build do
    sh "yarn run webpack-build"
  end

  desc "Watch the frontend with Webpack during development"
  task :dev do
    sh "yarn run webpack-dev --color"
  rescue Interrupt
  end
end

#
# Add your own Rake tasks here! You can use `environment` as a prerequisite
# in order to write automations or other commands requiring a loaded site.
#
# task :my_task => :environment do
#   puts site.root_dir
#   automation do
#     say_status :rake, "I'm a Rake tast =) #{site.config.url}"
#   end
# end

namespace :import do
  task :convertkit => :environment do
    # CONVERTKIT_API=yAo... bin/bt import:convertkit

    site # init

    broadcasts_count = site.collections.broadcasts.read.resources.count

    previous_issues = 11 + broadcasts_count

    api_secret = ENV["CONVERTKIT_API"]

    broadcasts = Faraday
      .get("https://api.convertkit.com/v3/broadcasts?api_secret=#{api_secret}")
      .body
      .then { JSON.parse(_1, symbolize_names: true) }

    broadcasts[:broadcasts].each do |broadcast|
      id = broadcast[:id]

      origin = Bridgetown::Model::RepoOrigin.new_with_collection_path(:broadcasts, "_broadcasts/#{id}.html")

      unless origin.exists?
        puts "* CREATING #{id}"
        item = Faraday
          .get("https://api.convertkit.com/v3/broadcasts/#{id}?api_secret=#{api_secret}")
          .body
          .then { JSON.parse(_1, symbolize_names: true)[:broadcast] }

        model = Bridgetown::Model::Base.new(number: previous_issues + 1, title: item[:subject], subtitle: "Issue description goes here.", date: item[:created_at])
        model.content = item[:content].gsub(/\<(\/?)h2\>/, "<\\1h3>").gsub("<p>​</p>", "")
        model.origin = origin
        model.save
      end
    end
  end

  task :youtube, [:url] => :environment do |task, args|
    # CONVERTKIT_API=Alz... bin/bt import:youtube[https://www.youtube.com/watch?v=8TIiLAYnj3A]

    require "yt"

    Yt.configure do |config|
      config.log_level = :debug
      config.api_key = ENV["YOUTUBE_API"]
    end

    site # init

    args.url

    yt_url = Yt::URL.new args.url

    video = yt_url.resource

    origin = Bridgetown::Model::RepoOrigin.new_with_collection_path(:posts, "_posts/videos/#{video.published_at.strftime("%Y")}/#{video.published_at.strftime("%Y-%m-%d")}-#{Bridgetown::Utils.slugify(video.title, mode: "ascii")}.md")

    model = Bridgetown::Model::Base.new(
      published: true,
      category: :videos,
      title: video.title,
      description: video.description.split(/\n/)[0],
      date: video.published_at,
      youtube_id: video.id,
      tags: "portland oregonexplored vlog" #default
    )
    model.content = video.description.gsub(/(\n)/, "  \\1")
    model.origin = origin
    model.save

    puts "Done! Saved in: #{origin.relative_path}"
  end
end

# Run rake without specifying any command to execute a deploy build by default.
task default: :deploy
