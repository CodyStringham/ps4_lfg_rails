Rails.application.routes.draw do

  root 'site#index'

  devise_for :users, skip: [:sessions]
  as :user do
    get '/sign-in', to: 'devise/sessions#new', as: :new_user_session
    post '/sign-in', to: 'devise/sessions#create', as: :user_session
    delete '/sign-out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    namespace :v1 do
      get '/users/:id', to: 'users#show'
      post '/user_login', to: 'users#user_login'
      post '/user_register', to: 'users#user_register'

      get '/:id', to: 'games#show', as: :direct_game
      get '/:game_id/:id', to: 'events#show', as: :direct_game_event
    end
  end

  authenticated :user, lambda {|u| u.admin } do
    resources :games do
      resources :events
    end
  end

  get '/:id', to: 'games#show', as: :direct_game
  get '/:game_id/:id', to: 'events#show', as: :direct_game_event

  scope '/:game_id/:event_id' do
    resources :posts, as: :game_event_posts
  end

end
