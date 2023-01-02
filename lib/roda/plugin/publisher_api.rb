class Roda
  module RodaPlugins
    module PublisherApi
      def self.klass_for_collection_label(label)
        Bridgetown::Model::Base.descendants.find do |klass|
          klass.will_load_id?("repo://#{label}.collection")
        end
      end

      module RequestMethods
        def publisher_api
          r = self
          scope.instance_exec do
            r.on "publisher_api" do
              r.on "collections" do
                r.is do
                  r.get do
                    {
                      collections: bridgetown_site.collections.values.map do |collection|
                        {
                          label: collection.label,
                          metadata: collection.metadata
                        }
                      end
                    }
                  end
                end

                r.on String do |collection_name|
                  # @type [Bridgetown::Collection]
                  collection = bridgetown_site.collections[collection_name.to_sym]

                  unless collection.present?
                    response.status = 404
                    return {
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

              r.on "models" do
                r.get %r{preview/([^/]*)/(.*)}, String, String do |collection, *path|
                  item = Bridgetown::Model::Base.find("repo://#{collection}.collection/#{path.join("/")}")
  
                  unless item.content.present?
                    response.status = 404
                    return "404 Not Found"
                  end
  
                  item.render_as_resource.output
                end

                r.get "new_filename_template", String do |collection|
                  model_klass = PublisherApi.klass_for_collection_label(collection)
                  if model_klass.respond_to?(:new_filename_template)
                    model_klass.new_filename_template(params)
                  else
                    "untitled.md"
                  end
                end

                r.get %r{([^/]*)/(.*)} do |collection, *path|
                  item = Bridgetown::Model::Base.find("repo://#{collection}.collection/#{path.join("/")}")

                  unless item.content.present?
                    response.status = 404
                    return {
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
              end
            end
          end
        end
      end
    end

    register_plugin :publisher_api, PublisherApi
  end
end
