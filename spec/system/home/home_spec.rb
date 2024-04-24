require 'rails_helper'

describe 'Home page' do
  it 'has appropriates links on the navbar when user is not logged in' do
    visit root_path

    expect(page).not_to have_link 'Cadastrar novo avaliado'
    expect(page).not_to have_link 'Avaliados'
    expect(page).to have_link 'Entrar'
  end

  it 'should display link to register new participant' do
    psychologist = create(:psychologist)

    login_as psychologist
    visit root_path

    expect(page).to have_link 'Meus avaliados'
    expect(page).to have_link 'Cadastrar novo avaliado'
    expect(page).to have_button 'Sair'
  end

  it 'displays a list with registered participants' do
    psychologist = create(:psychologist)

    create(:participant, name: 'João Carlos Fonseca', cpf: '32591177090',
                         email: 'carlos@email.com', date_of_birth: '2000-08-13', psychologist:)
    create(:participant, name: 'Maria Medeiros Martins', cpf: '94844643002',
                         email: 'maria@email.com', date_of_birth: '1994-04-21', psychologist:)
    create(:participant, name: 'Pedro Luis Maia', cpf: '11755836007',
                         email: 'pedro@email.com', date_of_birth: '1988-05-28', psychologist:)

    login_as psychologist
    visit root_path

    within 'main' do
      expect(page).to have_link 'Cadastrar novo avaliado'
    end

    within 'table tr:first-child' do
      expect(page).to have_selector 'th:nth-of-type(1)', text: 'Nome'
      expect(page).to have_selector 'th:nth-of-type(2)', text: 'CPF'
      expect(page).to have_selector 'th:nth-of-type(3)', text: 'E-mail'
      expect(page).to have_selector 'th:nth-of-type(4)', text: 'Data de nascimento'
    end

    within 'table tr:nth-child(2)' do
      expect(page).to have_selector 'td:nth-of-type(1)', text: 'João Carlos Fonseca'
      expect(page).to have_selector 'td:nth-of-type(2)', text: '32591177090'
      expect(page).to have_selector 'td:nth-of-type(3)', text: 'carlos@email.com'
      expect(page).to have_selector 'td:nth-of-type(4)', text: '13/08/2000'
    end

    within 'table tr:nth-child(3)' do
      expect(page).to have_selector 'td:nth-of-type(1)', text: 'Maria Medeiros Martins'
      expect(page).to have_selector 'td:nth-of-type(2)', text: '94844643002'
      expect(page).to have_selector 'td:nth-of-type(3)', text: 'maria@email.com'
      expect(page).to have_selector 'td:nth-of-type(4)', text: '21/04/1994'
    end

    within 'table tr:nth-child(4)' do
      expect(page).to have_selector 'td:nth-of-type(1)', text: 'Pedro Luis Maia'
      expect(page).to have_selector 'td:nth-of-type(2)', text: '11755836007'
      expect(page).to have_selector 'td:nth-of-type(3)', text: 'pedro@email.com'
      expect(page).to have_selector 'td:nth-of-type(4)', text: '28/05/1988'
    end
  end

  it 'displays message when no participant is registered' do
    psychologist = create(:psychologist)

    login_as psychologist
    visit root_path

    expect(page).to have_content 'Você ainda não tem avaliados cadastrados'
  end

  it 'cannot see other psychologists participants' do
    psychologist1 = create(:psychologist, email: 'psycho1@email.com')
    psychologist2 = create(:psychologist, email: 'psycho2@email.com')

    create(:participant, name: 'José Maria', cpf: '05298771041',
                         email: 'jm@email.com', psychologist: psychologist2)
    create(:participant, name: 'Maria Eduarda', cpf: '73316919023',
                         email: 'ma@email.com', psychologist: psychologist2)

    login_as psychologist1
    visit root_path

    expect(page).not_to have_content 'José Maria'
    expect(page).not_to have_content 'Maria Eduarda'
  end
end
