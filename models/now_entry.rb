class NowEntry < Bridgetown::Model::Base
  class << self
    def new_filename_template(_params)
      today = DateTime.now
      "#{today.strftime("%Y-%m-%d")}-now.md"
    end
  end
end
