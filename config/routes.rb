Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/about'

  devise_for :users, path: 'account', controllers: {
      registrations: :registrations,
      sessions: :sessions
  }

  #  -Topics & Replies
  resources :topic, only: [:show, :create], controller: 'topics' do
    resources :reply, only: [:create], controller: 'replies' # may need to implement destroy later
  end

  get 'node/:slug' => 'nodes#show', as: 'node'
  get 'node/:slug/new' => 'topics#new', as: 'new_topic'

  get 'user/:id' => 'user#show', as: 'user'

  resource :user_profile, except: [:new, :show, :destroy], controller: :user_profile
  resource :user_avatar, only: :update, controller: :user_avatar

  resource :notifications, only: :show
  resource :messages, except: [:update, :edit]

  # resources :node_category, only: :show, controller: 'node_categories'
  get 'node_category/:slug' => 'node_categories#show', as: 'node_category'

  # sidekiq - monitoring
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


  # for instructions of routing, please check the office-site's guide
  # http://guides.rubyonrails.org/routing.html
end
