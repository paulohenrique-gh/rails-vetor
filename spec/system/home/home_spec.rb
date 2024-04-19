require 'rails_helper'

describe 'Home page' do
  it 'should display link to register new participant' do
    visit root_path

    expect(page).to have_link 'Cadastrar novo avaliado'
  end
end
