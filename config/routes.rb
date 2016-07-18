Rails.application.routes.draw do
  root to: 'videos#recently'
  get '/search', to: 'videos#search'
  get '/videos/:short_url', to: 'videos#watch', as: :watch
  get '/categories/:category', to: 'videos#category', as: :category
  # auth
  get '/auth/:provider', to: -> (_) { [404, {}, ['Not found']] }, as: :login
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure', to: 'sessions#failure'
  get '/logout', to: 'sessions#destroy', as: :logout
  # api
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/videos', to: 'videos#all'
    end
  end
  # admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
