module MetaTaggable
  extend ActiveSupport::Concern

  include ActionView::Helpers::AssetUrlHelper

  included do
    before_action :prepare_meta_tags
  end

  private

  def prepare_meta_tags(options = {})
    base = t('meta_tags.base')

    site = title = Figaro.env.service_title
    description = base[:description]
    image = image_url('splash_sp.jpg')

    defaults = {
      title: title,
      og: {
        url: request.url,
        title: title,
        description: description,
        site_name: site,
        type: 'article',
        image: image
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags(options)
  end
end
