Rails.application.routes.draw do
  resources :signup, only: [:new, :create]

  get '/', to: "sessions#new", as: :login
  post '/', to: "sessions#create", as: nil
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :mail, only: [:index]

end
