Rails.application.routes.draw do
  root to: 'home#index'

  resources :participants, only: %i[show new create], shallow: true do
    resources :participant_instruments, only: %i[show new create] do
      get 'validation', to: 'participant_instruments#validation'
      post 'validate_participant', to: 'participant_instruments#validate_participant'
    end
  end

  # get 'participant_instruments/:participant_instrument_id', to: 'participant_instruments#show',
  #                                                           as: :participant_instruments do
  #   get 'validate_participant',
  #       to: 'participant_instruments#validate_participant'
  # end
end
