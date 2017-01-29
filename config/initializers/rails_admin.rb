RailsAdmin.config do |config|
  # Clearance
  config.parent_controller = "::ApplicationController"

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin?
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.model 'Video' do
    list do
      exclude_fields :id, :url, :thumbnail_url, :file_hash
    end

    edit do
      field :url
      field :thumbnail_url
      field :short_url
      field :title
      field :description
      field :chapter
      field :category
      field :duration
      field :state
      field :raw_info
      field :recorded_at do
        strftime_format '%Y-%m-%d %H:%M:%S'
      end
    end
  end
end
