require 'rails_helper'

describe 'Participant accesses instrument link' do
  it 'and is redirected to survey after successful validation' do
    participant = create(:participant, name: 'Carlos Andrade', email: 'carlos@email.com',
                                       cpf: '176.814.070-73', date_of_birth: '1987-12-06')
    instrument = create(:instrument)
    participant_instrument = participant.participant_instruments.create!(instrument:)

    visit participant_instrument_validation_path(participant_instrument)

    fill_in 'Nome', with: 'Carlos Andrade'
    fill_in 'CPF', with: '176.814.070-73'
    fill_in 'E-mail', with: 'carlos@email.com'
    fill_in 'Data de nascimento', with: '06/12/1987'
    click_on 'Próximo'

    expect(current_path).to eq participant_instrument_questionnaire_path(participant_instrument)
  end

  it 'and is not redirected if validation fails' do
    participant = create(:participant, name: 'Carlos Andrade', email: 'carlos@email.com',
                                       cpf: '176.814.070-73', date_of_birth: '1987-12-06')
    instrument = create(:instrument)
    participant_instrument = participant.participant_instruments.create!(instrument:)

    visit participant_instrument_validation_path(participant_instrument)

    fill_in 'Nome', with: 'Vitor Barbosa'
    fill_in 'CPF', with: '182.809.073-97'
    fill_in 'E-mail', with: 'vitor@email.com'
    fill_in 'Data de nascimento', with: '10/07/1992'
    click_on 'Próximo'

    expect(page).to have_content 'Dados incorretos'
    expect(current_path).not_to eq participant_instrument_questionnaire_path(participant_instrument)
  end
end
