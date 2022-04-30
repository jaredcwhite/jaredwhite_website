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

task :import_convertkit => :environment do
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

      model = Bridgetown::Model::Base.new(number: previous_issues + 1, title: item[:subject], date: item[:created_at])
      model.content = item[:content].gsub(/\<(\/?)h2\>/, "<\\1h3>").gsub("<hr/><p>​</p>", "<hr/>")
      model.origin = origin
      model.save
    end
  end
end

# Run rake without specifying any command to execute a deploy build by default.
task default: :deploy
