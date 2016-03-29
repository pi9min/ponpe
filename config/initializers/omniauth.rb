Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['google_oauth2_key'], ENV['google_oauth2_secret'],
    {
      name: 'google',
      scope: 'email, profile',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 60
    }
  OmniAuth.config.full_host = lambda do |env|
    scheme = Rails.env.production? ? 'https' : env['rack.url_scheme']
    local_host = env['HTTP_HOST']
    forwarded_host = env['HTTP_X_FORWARDED_HOST']
    forwarded_host.blank? ? "#{scheme}://#{local_host}" : "#{scheme}://#{forwarded_host}"
  end
end
