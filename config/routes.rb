Rails.application.routes.draw do

  get '/', to: "sessions#new", as: :login

end
