Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/about'

  devise_for :users, path: 'account', controllers: {
                       registrations: :registrations,
                       sessions: :sessions,
                       omniauth_callbacks: :'users/omniauth_callbacks'
                   }


  get 'quick_search/u' => 'quick_search#u', as: 'quick_search_user'

  get 'new_topic' => 'topics#new'
  # - Topics & Replies
  resources :topic, only: [:show, :new, :create], controller: 'topics' do
    resources :reply, only: [:create], controller: 'replies' # may need to implement destroy later
    # favorite
    resources :favorite_topic, only: [:create], controller: 'favorite_topics'
    delete 'cancel_favorite' => 'favorite_topics#destroy', as: 'favorite_topic'
    post :appreciate, only: [:appreciate], controller: 'topics'
    post 'reply/:reply_id/appreciate' => 'replies#appreciate', as: 'topic_reply_appreciate'
  end

  get 'node/:slug' => 'nodes#show', as: 'node'
  get 'node/:slug/new' => 'topics#new', as: 'new_node_topic'


  get 'user/:id' => 'user#show', as: 'user'
  resources :user do
    member do
      get 'topics' => 'user#topics'
      get 'replies' => 'user#replies'
    end
  end

  resource :user_profile, except: [:new, :show, :destroy], controller: :user_profile
  resource :user_avatar, only: :update, controller: :user_avatar
  scope :account do
    get 'favorites' => 'favorite_topics#show', as: 'account_favorite_topic'
    get 'fortune_alterations' => 'fortune_alterations#show'
    get 'daily_award' => 'fortune_alterations#daily_award'
  end

  resource :notifications, only: :show
  resource :messages, except: [:update, :edit]

  # resources :node_category, only: :show, controller: 'node_categories'
  get 'node_category/:slug' => 'node_categories#show', as: 'node_category'
  get 'nodes' => 'node_categories#all', as: 'all_nodes'

  # sidekiq - monitoring
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # Control Panel
  namespace :cpanel do
    root to: 'home#index'
    # NodeCategory
    resource :node_categories, only: [:show]
    resources :node_categories, only: [:edit, :update, :new, :create]
    # Node
    resource :nodes, only: [:show]
    resources :nodes, only: [:edit, :update, :new, :create]
    # User
    resource :users, only: [:show]
    resources :users, only: [:edit, :update]
    # Topic
    resource :topics, only: [:show]
    resources :topics, only: [:edit, :update]
    # Management Logs
    resource :management_logs, only: [:show]
  end


  # for instructions of routing, please check the office-site's guide
  # http://guides.rubyonrails.org/routing.html
end
