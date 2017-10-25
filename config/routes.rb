Rails.application.routes.draw do
  resources :signup, only: [:new, :create]

  get '/', to: "sessions#new", as: :login
  post '/', to: "sessions#create", as: nil
  delete '/logout', to: 'sessions#destroy', as: :logout

  post '/mail/compose', to: "mail#create", as: nil
  get '/mail/compose', to: "mail#new", as: :newmail
  get '/mail/received', to: "mail#receive", as: :receive
  get '/mail/received/:id', to: "mail#detailreceive", as: :detailreceive
  get '/mail/sent', to: "mail#sent", as: :sent
  get '/mail/sent/:id', to: "mail#detailsent", as: :detailsent
  resources :mail, only: [:index, :new, :create, :show]

  post '/friend', to: "friend#sendrequest", as: :request
  get '/request', to: "friend#listrequest", as: :listrequest
  get '/request/:id', to: "friend#accept", as: :accept
  get '/friends', to: "friend#index", as: :friendlist
  get '/friends/delete/:id', to: "friend#delete", as: :unfriend
  resources :friend, only: [:index, :new, :show]

end
