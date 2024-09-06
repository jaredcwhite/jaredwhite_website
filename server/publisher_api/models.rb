class PublisherAPI::Models < Bridgetown::Rack::Routes
  priority :low

  route do |r|
    r.on "publisher_api/models" do
      r.get %r{preview/([^/]*)/(.*)}, String, String do |collection, *path|
        item = Bridgetown::Model::Base.find("repo://#{collection}.collection/#{path.join("/")}")

        unless item.persisted?
          response.status = 404
          next "404 Not Found"
        end

        item.render_as_resource.output
      end

      r.is %r{([^/]*)/(.*)} do |collection, *path|
        r.get do
          item = Bridgetown::Model::Base.find("repo://#{collection}.collection/#{path.join("/")}")

          unless item.persisted?
            response.status = 404
            next {
              item: nil
            }
          end

          {
            item: {
              id: item.id,
              attributes: item.data_attributes,
              content: item.content
            }
          }
        end

        r.post do
          item = Bridgetown::Model::Base.find("repo://#{collection}.collection/#{path.join("/")}")

          params[collection]&.each do |key, value|
            next if key.to_s.start_with?("_") && key.to_s != "_content_"

            if value.nil?
              item.attributes.delete(key)
            else
              item.attributes[key] = value
            end
          end

          "#{item.origin.send(:front_matter_to_yaml, item)}---\n\n#{item.content}"
        end
      end
    end
  end
end
