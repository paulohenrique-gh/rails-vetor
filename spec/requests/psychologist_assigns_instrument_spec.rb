require 'rails_helper'

describe 'Psychologist assigns instrument to participant' do
  it 'and fails when participant does not exist' do
    psychologist = create(:psychologist)
    instrument_id = create(:instrument).id

    login_as psychologist
    post participant_participant_instruments_path(9999), params: {
      participant_instrument: { instrument_id: }
    }

    expect(response).to redirect_to root_path
  end

  it 'and fails when instrument does not exist' do
    psychologist = create(:psychologist)
    participant = create(:participant, psychologist:)

    login_as psychologist
    post participant_participant_instruments_path(participant), params: {
      participant_instrument: { instrument_id: 9999 }
    }

    expect(response).to redirect_to root_path
  end

  it 'and fails if not logged in' do
    participant = create(:participant)
    instrument_id = create(:instrument).id

    post participant_participant_instruments_path(participant), params: {
      participant_instrument: { instrument_id: }
    }

    expect(response).to redirect_to new_psychologist_session_path
    expect(ParticipantInstrument.count).to eq 0
  end

  it 'and fails when participant is associated with another psychologist' do
    psychologist1 = create(:psychologist)
    psychologist2 = create(:psychologist)
    participant = create(:participant, psychologist: psychologist2)
    instrument_id = create(:instrument).id

    login_as psychologist1
    post participant_participant_instruments_path(participant), params: {
      participant_instrument: { instrument_id: }
    }

    expect(response).to redirect_to root_path
    expect(ParticipantInstrument.count).to eq 0
  end
end
