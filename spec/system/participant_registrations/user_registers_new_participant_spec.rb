require 'rails_helper'

describe 'User registers new participants' do
  it 'from the home page' do
    visit root_path
    click_on 'Cadastrar novo avaliado'

    fill_in 'Nome', with: 'João Luiz Medeiros'
    fill_in 'CPF', with: '01234567890'
    fill_in 'E-mail', with: 'joao@medeiros.com'
    fill_in 'Data de nascimento', with: '21/05/1999'
    click_on 'Salvar'

    expect(page).to have_content 'Avaliado cadastrado com sucesso'
    expect(page).to have_current_path participant_path(Participant.last)
  end
end
