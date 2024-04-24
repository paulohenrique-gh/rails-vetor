require 'rails_helper'

describe 'Psychologist registers new participants' do
  it 'from the home page' do
    psychologist = create(:psychologist)

    login_as psychologist
    visit root_path
    within 'nav' do
      click_on 'Cadastrar novo avaliado'
    end

    fill_in 'Nome', with: 'João Luiz Medeiros'
    fill_in 'CPF', with: '687.471.980-79'
    fill_in 'E-mail', with: 'joao@medeiros.com'
    fill_in 'Data de nascimento', with: '21/05/1999'
    click_on 'Salvar'

    expect(page).to have_content 'Avaliado cadastrado com sucesso'
    expect(page).to have_current_path participant_path(Participant.last)
  end

  it 'and fails when fields are invalid or blank' do
    psychologist = create(:psychologist)

    login_as psychologist
    visit new_participant_path

    fill_in 'Nome', with: ''
    fill_in 'CPF', with: '1111111111111111111'
    fill_in 'E-mail', with: 'email inválido'
    fill_in 'Data de nascimento', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível cadastrar avaliado'
  end
end
