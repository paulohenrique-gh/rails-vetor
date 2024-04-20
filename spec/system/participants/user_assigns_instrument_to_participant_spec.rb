require 'rails_helper'

describe 'User assigns instrument to participant' do
  it 'successfully' do
    participant = create(:participant)
    create(:instrument, name: 'Teste de Depressão',
                        description: 'Avalia probabilidade de depressão no avaliado')
    create(:instrument, name: 'Teste de Ansiedade',
                        description: 'Avalia possibilidade de quadro ansioso')

    visit new_participant_participant_instrument_path(participant)
    select 'Teste de Ansiedade', from: 'Instrumento'
    click_on 'Aplicar'

    expect(page).to have_current_path participant_path(participant)
    expect(page).to have_content 'Instrumento aplicado com sucesso!'
    within 'table' do
      expect(page).to have_content 'Teste de Ansiedade'
      expect(page).to have_content 'Pendente'
    end
  end
end
