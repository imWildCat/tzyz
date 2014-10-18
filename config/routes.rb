Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/about'

  devise_for :users, path: 'account', controllers: {
      registrations: :registrations,
      sessions: :sessions
  }

  #  -Topics & Replies
  resources :topic, only: [:new, :show, :create], controller: 'topics' do
    resources :reply, only: [:create], controller: 'replies' # may need to implement destroy later
  end

  get 'node/:slug' => 'nodes#show', as: 'node'
  get 'user/:id' => 'user#show', as: 'user'

  resource :user_profile, except: [:new, :show, :destroy], controller: :user_profile
  resource :user_avatar, only: :update, controller: :user_avatar


  # for instructions of routing, please check the office-site's guide
  # http://guides.rubyonrails.org/routing.html
end
