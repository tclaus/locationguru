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
      post 'restrict'
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:show, :create, :destroy]
    resources :messages, only: [:show, :create, :destroy]
  end

  resources :cities, only: [:show]

  controller :reservation do
      get '/reservations/show_all'
      patch '/reservations/accept'
      patch '/reservations/reject'
  end

  get 'search' => 'pages#search'

  get 'impressum' => 'impressum#show'
  get 'privacy' => 'privacy#show'
  get 'gtc' => 'gtc#show_gtc'
  get 'contact' => 'contact#show'

  # DashboardsController
  controller :dashboards do
    get 'dashboard' => :index
    get 'dashboard/unread_count' => :unreadMessageCount
    get 'dashboard/unread_count_json' => :unreadMessageCountJSON
  end

 # Guids
  controller :guides do
    get 'guides/kgv' => :kgv
    get 'guides/clubhouse' => :kgv
  end

  # Admin
  controller :admin do
    get 'admin' => :index
    get 'admin/users' => :users
    get 'admin/locations' => :locations
    post 'admin/recalculation' => :recalculation
  end

  # payments
  get 'payment_method' => 'users#payment'
  delete 'payment_method' => 'users#delete_card'
  post 'add_card' => 'users#add_card'

  get 'subscriptions' => 'subscriptions#view'
  post'subscriptions' => 'subscriptions#toggleSubscription'


  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

end
