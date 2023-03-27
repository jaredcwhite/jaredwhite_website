class PublisherApi::Collections < Bridgetown::Rack::Routes
  priority :low

  route do |r|
    r.on "publisher_api/collections" do
      r.is do
        r.get do
          {
            collections: bridgetown_site.collections.values.map do |collection|
              {
                label: collection.label,
                metadata: collection.metadata,
                title: collection.metadata.title,
                folder_name: collection.folder_name
              }
            end
          }
        end
      end

      r.get "editor_views", String do |collection_name|
        collection = bridgetown_site.collections[collection_name.to_sym]

        unless collection.present?
          response.status = 404
          next "404 Not Found"
        end

        begin
          editor_component = "PublisherViews::#{collection.label.camelize}".constantize
        rescue NameError
          response.status = 404
          next "404 Not Found"
        end

        editor_component.new(request: r).template
      end

      r.on String do |collection_name|
        # @type [Bridgetown::Collection]
        collection = bridgetown_site.collections[collection_name.to_sym]

        unless collection.present?
          response.status = 404
          next {
            collection: nil
          }
        end

        collection.resources.clear
        collection.read
        {
          collection: {
            label: collection.label,
            metadata: collection.metadata,
            title: collection.metadata.title,
            folder_name: collection.folder_name,
            models: collection.resources.map(&:model).uniq.map do |model|
              {
                id: model.id
              }
            end
          }
        }
      end
    end
  end
end
