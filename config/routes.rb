# frozen_string_literal: true

require 'resque/server'

Rails.application.routes.draw do
  root 'pages#home'
  get 'sitemap.xml', to: 'sitemap#index', defaults: { format: 'xml' }

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login',
                           sign_out: 'logout',
                           edit: 'profile',
                           sign_up: 'registration' }

  authenticate :user do
    mount Resque::Server, at: '/jobs'
  end

  resources :users, only: [:show] do
    member do
      post '/verify_phone_number', to: 'users#verify_phone_number'
      patch '/update_phone_number', to: 'users#update_phone_number'
      post 'avatar'
      delete '' => 'users#destroy'
    end
  end

  resources :locations, except: [:edit] do
    member do
      get 'listing'
      get 'description'
      get 'photo_upload'
      get 'suitables'
      get 'amenities'
      get 'location'
      get 'preload'
      get 'preview'
      get 'send_message'
      post 'restrict'
    end

    resources :photos, only: %i[create destroy]
    resources :reservations, only: %i[show create destroy]
    resources :messages, only: %i[show create destroy]
  end

  controller :location_reviews do
    get 'review/new/:review_token', to: 'location_reviews#new', as: 'new_review'
    post 'review', to: 'location_reviews#create'
    delete 'review/:id', to: 'location_reviews#delete'
  end

  get 'messages/:id', to: 'messages#show_message', as: 'show_message'

  controller :photos do
    post 'photos/main_photo'
  end

  resources :cities, only: [:show]

  controller :language do
    get 'language/:language', to: 'language#language', as: 'language'
  end

  controller :reservation do
    get '/reservations/show_all'
    patch '/reservations/accept'
    patch '/reservations/reject'
  end

  get 'search', to: 'pages#search'

  get 'impressum', to: 'impressum#show'
  get 'privacy', to: 'privacy#show'
  get 'gtc', to: 'gtc#show_gtc'
  get 'contact', to: 'contact#show'

  # DashboardsController
  controller :dashboards do
    get 'dashboard' => :index
    get 'dashboard/unread_count' => :unread_message_count
    get 'dashboard/unread_count_json' => :unread_message_count_json
  end

  # Guids
  controller :guides do
    get 'guides/partyvenues' => :partyvenues
    get 'guides/multi_purpose_rooms' => :multi_purpose_rooms
    get 'guides/clubhouses' => :clubhouses
    get 'guides/pubs' => :pubs
    get 'guides/restaurants' => :restaurants
  end

  # Admin
  controller :admin do
    get 'admin' => :index
    get 'admin/users' => :users
    get 'admin/export_users' => :export_users
    get 'admin/export_messages' => :export_messages
    get 'admin/locations' => :locations
    get 'admin/active_locations' => :active_locations
    get 'admin/messages' => :messages
    post 'admin/recalculation' => :recalculation
  end

  # Receive webhooks
  namespace :webhooks do
    post 'mails', to: 'mails'
  end

  %w[404 422 500].each do |code|
    get code, to: 'errors#show', code: code
  end

  # Fast exit hack attempts
  get 'wp-login.php', to: 'errors#show', code: 404
  get 'blog/wp-login.php', to: 'errors#show', code: 404
end
