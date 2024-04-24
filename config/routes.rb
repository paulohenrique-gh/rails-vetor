Rails.application.routes.draw do
  devise_for :psychologists
  root to: 'home#index'

  resources :participants, only: %i[show new create], shallow: true do
    resources :participant_instruments, only: %i[create] do
      get 'validation', to: 'participants#validation'
      post 'validate_participant', to: 'participants#validate_participant'
      get 'questionnaire', to: 'instruments#load_questionnaire'
      post 'submit', to: 'answers#create'
      get 'results', to: 'results#show'
    end
  end

  get 'instrument_completion', to: 'instruments#completion'
end
