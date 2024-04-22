Rails.application.routes.draw do
  root to: 'home#index'

  resources :participants, only: %i[show new create], shallow: true do
    resources :participant_instruments, only: %i[show new create] do
      get 'validation', to: 'participant_instruments#validation'
      post 'validate_participant', to: 'participant_instruments#validate_participant'
      post 'submit', to: 'responses#create'
    end
  end
end
