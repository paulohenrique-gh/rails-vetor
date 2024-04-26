require 'rails_helper'

describe 'Participant details page' do
  it 'redirects to login page if not authenticated' do
    participant = create(:participant)

    get participant_path(participant)

    expect(response).to redirect_to new_psychologist_session_path
  end

  it 'redirects to home page if participant is associated with another psychologist' do
    psychologist1 = create(:psychologist)
    psychologist2 = create(:psychologist)

    participant = create(:participant, psychologist: psychologist2)

    login_as psychologist1
    get participant_path(participant)

    expect(response).to redirect_to root_path
  end
end
