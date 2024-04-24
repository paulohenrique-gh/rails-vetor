require 'rails_helper'

describe 'Psychologist assigns instrument to participant' do
  it 'successfully' do
    psychologist = create(:psychologist)

    participant = create(:participant, psychologist:)
    create(:instrument, name: 'Teste de Depressão',
                        description: 'Avalia probabilidade de depressão no avaliado')
    create(:instrument, name: 'Teste de Ansiedade',
                        description: 'Avalia possibilidade de quadro ansioso')

    login_as psychologist
    visit participant_path(participant)
    select 'Teste de Ansiedade', from: 'Instrumento'
    click_on 'Aplicar novo instrumento'

    expect(page).to have_current_path participant_path(participant)
    expect(page).to have_content 'Instrumento aplicado com sucesso!'
    within 'table' do
      expect(page).to have_content 'Teste de Ansiedade'
      expect(page).to have_content 'Pendente'
    end
    email = ActionMailer::Base.deliveries.find { |mail| mail.to.include?(participant.email) }
    expect(email.to).to include participant.email
  end
end
