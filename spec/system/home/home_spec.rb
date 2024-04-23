require 'rails_helper'

describe 'Home page' do
  it 'should display link to register new participant' do
    visit root_path

    expect(page).to have_link 'Cadastrar novo avaliado'
  end

  it 'displays a list with registered participants' do
    create(:participant, name: 'João Carlos Fonseca', cpf: '32591177090',
                         email: 'carlos@email.com', date_of_birth: '2000-08-13')
    create(:participant, name: 'Maria Medeiros Martins', cpf: '94844643002',
                         email: 'maria@email.com', date_of_birth: '1994-04-21')
    create(:participant, name: 'Pedro Luis Maia', cpf: '11755836007',
                         email: 'pedro@email.com', date_of_birth: '1988-05-28')

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
    visit root_path

    expect(page).to have_content 'Você ainda não tem avaliados cadastrados'
  end
end
