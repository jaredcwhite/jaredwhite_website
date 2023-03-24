class Post < Bridgetown::Model::Base
  class << self
    def new_filename_template(params)
      today = DateTime.now
      year = today.strftime("%Y")
      "#{params.fetch("category", "thoughts")}/#{year}/#{today.strftime("%Y-%m-%d")}-untitled.md"
    end
  end
end
