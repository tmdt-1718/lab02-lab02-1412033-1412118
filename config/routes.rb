Rails.application.routes.draw do
  resources :signup, only: [:new, :create]

  get '/', to: "sessions#new", as: :login
  post '/', to: "sessions#create", as: nil
  delete '/logout', to: 'sessions#destroy', as: :logout

  get '/mail/received', to: "mail#receive", as: :receive
  get '/mail/received/:id', to: "mail#detailreceive", as: :detailreceive
  get '/mail/sent', to: "mail#sent", as: :sent
  get '/mail/sent/:id', to: "mail#detailsent", as: :detailsent
  resources :mail, only: [:index, :new, :create, :show]

  get '/friends', to: "friend#index", as: :friendlist

end
