require 'rails_helper'

describe 'Psychologist tries to access instrument results' do
  it 'and participant is associated with another psychologist' do
    psychologist1 = create(:psychologist)
    psychologist2 = create(:psychologist)

    participant = create(:participant, psychologist: psychologist2)
    participant_instrument = create(:participant_instrument, participant:)

    login_as psychologist1
    get participant_instrument_results_path(participant_instrument)

    expect(response).to redirect_to root_path
  end

  it 'and fails if not logged in' do
    psychologist = create(:psychologist)
    participant = create(:participant, psychologist:)
    participant_instrument = create(:participant_instrument, participant:)

    get participant_instrument_results_path(participant_instrument)

    expect(response).to redirect_to new_psychologist_session_path
  end
end
