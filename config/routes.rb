Rails.application.routes.draw do
  devise_for :psychologists
  root to: 'home#index'

  resources :participants, only: %i[show new create], shallow: true do
    resources :participant_instruments, only: %i[show create] do
      get 'validation', to: 'participants#validation'
      post 'validate_participant', to: 'participants#validate_participant'
      post 'submit', to: 'answers#create'
      
      get 'questionnaire', to: 'instruments#load_questionnaire'
    end
  end

  get 'instrument_completion', to: 'instruments#completion'
end
