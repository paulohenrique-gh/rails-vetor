require 'rails_helper'

describe 'User tries to register participant' do
  it 'and fails if not logged in' do
    psychologist = create(:psychologist)
    participant_params = {
      participant: {
        name: 'João Arruda',
        cpf: '65363517035',
        email: 'joao@email.com',
        date_of_birth: '1999-01-29',
        psychologist_id: psychologist.id
      }
    }

    post participants_path, params: participant_params

    expect(response).to redirect_to new_psychologist_session_path
    expect(Participant.count).to eq 0
  end

  it 'and fails when associated with other psychologist' do
    psychologist1 = create(:psychologist)
    psychologist2 = create(:psychologist)
    participant_params = {
      participant: {
        name: 'João Arruda',
        cpf: '65363517035',
        email: 'joao@email.com',
        date_of_birth: '1999-01-29',
        psychologist_id: psychologist2.id
      }
    }

    login_as psychologist1
    post participants_path, params: participant_params

    expect(Participant.last.psychologist).to eq psychologist1
  end
end
