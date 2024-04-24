require 'rails_helper'

describe 'User creates new psychologist account' do
  it 'after trying to access home page' do
    visit root_path
    click_on 'Criar conta'

    fill_in 'E-mail', with: 'psicologo@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmação de senha', with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'Você ainda não tem avaliados cadastrados'
    expect(Psychologist.count).to eq 1
  end

  it 'and logs in' do
    create(:psychologist, email: 'psicologo@email.com', password: 'password')

    visit root_path

    within '#new_psychologist' do
      fill_in 'E-mail', with: 'psicologo@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Logado com sucesso.'
  end
end
