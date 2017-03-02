Rails.application.routes.draw do
  resources :conversations
  root "welcome#welcome"

  get '/signup', to: "registrations#new"
  post '/signup', to: "registrations#create"

  get 'login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: "users#dashboard"

  get 'users/:id', to: "users#show", as: "profile"
  #get 'groups/:slug/join', to: "groups#join"

  delete 'groups/:slug', to: 'groups#destroy'
  #get 'groups/:slug/deactivate', to: 'groups#deactivate', as: "deactivate"
  get 'groups/:slug/modify', to: 'groups#modify', as: "modify_group"

  resources :groups, param: :slug
  resources :messages
  resources :replies

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
