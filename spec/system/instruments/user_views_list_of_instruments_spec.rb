require 'rails_helper'

describe 'User views list of available instruments' do
  it 'on the participant page' do
    participant = create(:participant)
    create(:instrument, name: 'Teste de Depressão',
                        description: 'Avalia probabilidade de depressão no avaliado')
    create(:instrument, name: 'Teste de Ansiedade',
                        description: 'Avalia possibilidade de quadro ansioso')
    create(:instrument, name: 'Teste de Autoestima',
                        description: 'Avalia autoestima do avaliado')

    visit participant_path(participant)

    expected_options = ['Teste de Depressão', 'Teste de Ansiedade', 'Teste de Autoestima']
    expect(page).to have_select('participant_instrument_instrument_id',
                                with_options: expected_options)
  end
end
