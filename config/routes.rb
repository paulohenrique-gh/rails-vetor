Rails.application.routes.draw do
  root to: 'home#index' 

  resources :participants, only: %i[show new create] do
    resources :participant_instruments, only: %i[new create]
  end
end
