require 'rails_helper'

describe 'Participant tries to access instrument page' do
  it 'and is redirected to validation page' do
    participant_instrument = create(:participant_instrument)

    get participant_instrument_questionnaire_path(participant_instrument)

    expect(response).to redirect_to participant_instrument_validation_path(participant_instrument)
  end
end
