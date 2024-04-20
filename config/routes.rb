Rails.application.routes.draw do
  root to: 'home#index'

  resources :participants, only: %i[show new create] do
    resources :participant_instruments, only: %i[new create]
  end

  get 'participant_instruments/:participant_instrument_id',
      to: 'participant_instruments#show',
      as: :participant_instruments
end
