require 'resque/server'

Rails.application.routes.draw do

  root 'pages#home'

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login',
                           sign_out: 'logout',
                           edit: 'profile',
                           sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks',
                            registrations: 'registrations' }

  authenticate :user do
    mount Resque::Server, at: '/jobs'
  end

  resources :users, only: [:show] do
    member do
      post '/verify_phone_number' => 'users#verify_phone_number'
      patch '/update_phone_number' => 'users#update_phone_number'
      post 'avatar'
    end
  end

  resources :locations, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'suitables'
      get 'amenities'
      get 'location'
      get 'preload'
      get 'preview'
      get 'send_message'
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
    resources :messages, only: [:create, :show, :destroy]
  end

  resources :cities, only: [:show]
  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]

  get '/your_trips' => 'reservations#your_trips'
  get '/your_reservations' => 'reservations#your_reservations'

  get 'search' => 'pages#search'

  get 'impressum' => 'impressum#show'
  get 'privacy' => 'privacy#show'
  get 'contact' => 'contact#show'

  # DashboardsController
  get 'dashboard' => 'dashboards#index'
  get 'dashboard/unread_count' => 'dashboards#unreadMessageCount'
  get 'dashboard/unread_count_json' => 'dashboards#unreadMessageCountJSON'

  # Admin
  controller :admin do
    get 'admin' => :index
    get 'admin/users' => :users
    get 'admin/locations' => :locations
    post 'admin/recalculation' => :recalculation
  end

  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

end
