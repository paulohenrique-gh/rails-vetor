require 'rails_helper'

describe 'Participant views instrument questions' do
  it 'after validating their info' do
    participant = create(:participant, name: 'Carlos Andrade', email: 'carlos@email.com',
                                       cpf: '176.814.070-73', date_of_birth: '1987-12-06')
    instrument = create(:instrument)
    participant_instrument = participant.participant_instruments.create!(instrument:)

    allow_any_instance_of(ParticipantInstrumentsController)
      .to receive(:participant_validated?)
      .and_return(true)

    visit participant_instrument_path(participant_instrument)

    expect(page).to have_selector '#participant_info'
    expect(page).to have_content 'Questão 1'
    expect(page).to have_content 'Opção 1/a'
    expect(page).to have_content 'Opção 1/b'
    expect(page).to have_content 'Opção 1/c'
    expect(page).to have_content 'Opção 1/d'

    expect(page).to have_content 'Questão 2'
    expect(page).to have_content 'Opção 2/a'
    expect(page).to have_content 'Opção 2/b'
    expect(page).to have_content 'Opção 2/c'
    expect(page).to have_content 'Opção 2/d'

    expect(page).to have_content 'Questão 3'
    expect(page).to have_content 'Opção 3/a'
    expect(page).to have_content 'Opção 3/b'
    expect(page).to have_content 'Opção 3/c'
    expect(page).to have_content 'Opção 3/d'

    expect(page).to have_content 'Questão 4'
    expect(page).to have_content 'Opção 4/a'
    expect(page).to have_content 'Opção 4/b'
    expect(page).to have_content 'Opção 4/c'
    expect(page).to have_content 'Opção 4/d'

    expect(page).to have_content 'Questão 5'
    expect(page).to have_content 'Opção 5/a'
    expect(page).to have_content 'Opção 5/b'
    expect(page).to have_content 'Opção 5/c'
    expect(page).to have_content 'Opção 5/d'
  end
end
