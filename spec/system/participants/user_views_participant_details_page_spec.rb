require 'rails_helper'

describe 'User views participant page' do
  it 'and the details are displayed' do
    participant = create(:participant, name: 'Mara Cristina Pereira', cpf: '414.298.400-48',
                                       email: 'mara@email.com', date_of_birth: '1989-12-09')

    instrument_one = create(:instrument, name: 'Teste de Depressão',
                                         description: 'Avalia probalidade de depressão')
    instrument_two = create(:instrument, name: 'Teste de Ansiedade Geral',
                                         description: 'Avalia possibilidade de quadro ansioso')

    participant.participant_instruments.create!(instrument: instrument_one, status: :pending,
                                                created_at: '2022-01-29')
    participant.participant_instruments.create!(instrument: instrument_two, status: :finished,
                                                created_at: '2021-03-14', finished_at: '2021-03-17')

    # TODO: visit root path after creating participants list on the home page
    visit participant_path(participant)

    expect(page).to have_content 'Mara Cristina Pereira'
    expect(page).to have_content '414.298.400-48'
    expect(page).to have_content 'mara@email.com'
    expect(page).to have_content '09/12/1989'
    expect(page).to have_link 'Aplicar novo instrumento'

    within 'table tr:first-child' do
      expect(page).to have_selector 'th:nth-of-type(1)', text: 'Nome'
      expect(page).to have_selector 'th:nth-of-type(2)', text: 'Descrição'
      expect(page).to have_selector 'th:nth-of-type(3)', text: 'Status'
      expect(page).to have_selector 'th:nth-of-type(4)', text: 'Data de aplicação'
      expect(page).to have_selector 'th:nth-of-type(5)', text: 'Data de finalização'
      expect(page).to have_selector 'th:nth-of-type(6)', text: 'Pontuação'
    end

    within 'table tr:nth-child(2)' do
      expect(page).to have_selector 'td:nth-of-type(1)', text: 'Teste de Depressão'
      expect(page).to have_selector 'td:nth-of-type(2)', text: 'Avalia probalidade de depressão'
      expect(page).to have_selector 'td:nth-of-type(3)', text: 'Pendente'
      expect(page).to have_selector 'td:nth-of-type(4)', text: '29/01/2022'
      expect(page).to have_selector 'td:nth-of-type(5)', text: ''
      # TODO: update score here after implementing it in other issue
      expect(page).to have_selector 'td:nth-of-type(6)', text: ''
    end

    within 'table tr:nth-child(3)' do
      expect(page).to have_selector 'td:nth-of-type(1)', text: 'Teste de Ansiedade Geral'
      expect(page).to have_selector 'td:nth-of-type(2)', text: 'Avalia possibilidade de quadro ansioso'
      expect(page).to have_selector 'td:nth-of-type(3)', text: 'Finalizado'
      expect(page).to have_selector 'td:nth-of-type(4)', text: '14/03/2021'
      expect(page).to have_selector 'td:nth-of-type(5)', text: '17/03/2021'
      expect(page).to have_selector 'td:nth-of-type(6)', text: ''
    end
  end
end
