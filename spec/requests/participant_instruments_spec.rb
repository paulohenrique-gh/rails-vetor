require 'rails_helper'

describe 'User assigns instrument to participant' do
  it 'and fails when participant does not exist' do
    instrument_id = create(:instrument).id

    post participant_participant_instruments_path(9999), params: {
      participant_instrument: { instrument_id: }
    }

    expect(response).to redirect_to root_path
  end

  it 'and fails when instrument does not exist' do
    participant = create(:participant)

    post participant_participant_instruments_path(participant), params: {
      participant_instrument: { instrument_id: 9999 }
    }

    expect(response).to redirect_to root_path
  end
end
