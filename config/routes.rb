Rails.application.routes.draw do
  root to: 'home#index' 

  resources :participants, only: %i[new create]
end
