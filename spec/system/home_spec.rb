require 'rails_helper'

describe 'Home page' do
  it 'should display Hello world' do
    visit root_path

    expect(page).to have_content 'Hello world'
  end
end
