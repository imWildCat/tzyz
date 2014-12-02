Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/about'

  devise_for :users, path: 'account', controllers: {
                       registrations: :registrations,
                       sessions: :sessions
                   }

  # - Topics & Replies
  resources :topic, only: [:show, :create], controller: 'topics' do
    resources :reply, only: [:create], controller: 'replies' # may need to implement destroy later
    # favorite
    resources :favorite_topic, only: [:create], controller: 'favorite_topics'
    delete 'cancel_favorite' => 'favorite_topics#destroy', as: 'favorite_topic'
    post :appreciate, only: [:appreciate], controller: 'topics'
    post 'reply/:reply_id/appreciate' => 'replies#appreciate', as: 'topic_reply_appreciate'
  end

  get 'node/:slug' => 'nodes#show', as: 'node'
  get 'node/:slug/new' => 'topics#new', as: 'new_topic'


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
    resource :node_categories, only: [:show]
  end


  # for instructions of routing, please check the office-site's guide
  # http://guides.rubyonrails.org/routing.html
end
