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
end
