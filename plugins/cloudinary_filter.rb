require "cloudinary"

# TODO: replace with the real Bridgetown Cloudinary plugin!
module MySite
  module CloudinaryFilter
    def cloudinary_url(input, attr_string="", image_format='jpg')
      cloudinary_url = Cloudinary::Utils.cloudinary_url(input, {format: image_format})
      if attr_string.present?
        cloudinary_url.sub!("/image/upload", "/image/upload/#{attr_string}")
      end
      cloudinary_url
    end
  end
end

Cloudinary.config({
  "cloud_name" => 'mariposta',
  "secure" => true
})

Liquid::Template.register_filter MySite::CloudinaryFilter
Bridgetown::RubyTemplateView::Helpers.include MySite::CloudinaryFilter
