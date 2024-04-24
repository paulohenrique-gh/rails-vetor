require 'rails_helper'

describe 'Psychologist views intrument results page' do
  it 'with finished status' do
    psychologist = create(:psychologist)

    participant = create(:participant, psychologist:)
    instrument = create(:instrument, name: 'Teste de Autoestima',
                                     description: 'Avalia autoestima do indivíduo')

    participant_instrument = create(:participant_instrument, participant:, instrument:,
                                                             status: :finished,
                                                             score: 8, finished_at: '2023-12-11')

    question1 = create(:question, description: 'Descrição questão 1', instrument:)
    question1_3points = create(:option, description: 'Opção 1', weight: 3, question: question1)
    create(:option, description: 'Opção 2', weight: 2, question: question1)
    create(:option, description: 'Opção 3', weight: 1, question: question1)
    create(:option, description: 'Opção 4', weight: 0, question: question1)

    question2 = create(:question, description: 'Descrição questão 2', instrument:)
    create(:option, description: 'Opção 1', weight: 3, question: question2)
    create(:option, description: 'Opção 2', weight: 2, question: question2)
    question2_1points = create(:option, description: 'Opção 3', weight: 1, question: question2)
    create(:option, description: 'Opção 4', weight: 0, question: question2)

    question3 = create(:question, description: 'Descrição questão 3', instrument:)
    create(:option, description: 'Opção 1', weight: 3, question: question3)
    create(:option, description: 'Opção 2', weight: 2, question: question3)
    create(:option, description: 'Opção 3', weight: 1, question: question3)
    question3_0points = create(:option, description: 'Opção 4', weight: 0, question: question3)

    question4 = create(:question, description: 'Descrição questão 4', instrument:)
    create(:option, description: 'Opção 1', weight: 3, question: question4)
    question4_2points = create(:option, description: 'Opção 2', weight: 2, question: question4)
    create(:option, description: 'Opção 3', weight: 1, question: question4)
    create(:option, description: 'Opção 4', weight: 0, question: question4)

    question5 = create(:question, description: 'Descrição questão 5', instrument:)
    question5_3points = create(:option, description: 'Opção 1', weight: 3, question: question5)
    create(:option, description: 'Opção 2', weight: 2, question: question5)
    create(:option, description: 'Opção 3', weight: 1, question: question5)
    create(:option, description: 'Opção 4', weight: 0, question: question5)

    create(:answer, option: question1_3points, participant_instrument:)
    create(:answer, option: question2_1points, participant_instrument:)
    create(:answer, option: question3_0points, participant_instrument:)
    create(:answer, option: question4_2points, participant_instrument:)
    create(:answer, option: question5_3points, participant_instrument:)

    login_as psychologist
    visit participant_path(participant)
    click_on 'Detalhes'

    expect(page).to have_selector '#participant_info'
    expect(page).to have_content 'Teste de Autoestima'
    expect(page).to have_content 'Avalia autoestima do indivíduo'
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Finalizado'
    expect(page).to have_content 'Aplicado em'
    expect(page).to have_content I18n.l(participant_instrument.created_at.to_date)
    expect(page).to have_content 'Concluído em'
    expect(page).to have_content '11/12/2023'

    within '#question1' do
      expect(page).to have_content 'Descrição questão 1'
      expect(page).to have_content 'Resposta do avaliado'
      expect(page).to have_content 'Opção 1'
      expect(page).to have_content 'Pontuação individual'
      expect(page).to have_content '3'
    end

    within '#question2' do
      expect(page).to have_content 'Descrição questão 2'
      expect(page).to have_content 'Resposta do avaliado'
      expect(page).to have_content 'Opção 3'
      expect(page).to have_content 'Pontuação individual'
      expect(page).to have_content '1'
    end

    within '#question3' do
      expect(page).to have_content 'Descrição questão 3'
      expect(page).to have_content 'Resposta do avaliado'
      expect(page).to have_content 'Opção 4'
      expect(page).to have_content 'Pontuação individual'
      expect(page).to have_content '0'
    end

    within '#question4' do
      expect(page).to have_content 'Descrição questão 4'
      expect(page).to have_content 'Resposta do avaliado'
      expect(page).to have_content 'Opção 2'
      expect(page).to have_content 'Pontuação individual'
      expect(page).to have_content '2'
    end

    within '#question5' do
      expect(page).to have_content 'Descrição questão 5'
      expect(page).to have_content 'Resposta do avaliado'
      expect(page).to have_content 'Opção 1'
      expect(page).to have_content 'Pontuação individual'
      expect(page).to have_content '3'
    end

    expect(page).to have_content 'Pontuação total'
    expect(page).to have_content '8'
  end

  it 'with pending status' do
    psychologist = create(:psychologist)
    participant = create(:participant, psychologist:)
    instrument = create(:instrument, name: 'Teste de Autoestima',
                                     description: 'Avalia autoestima do indivíduo')

    participant_instrument = create(:participant_instrument, participant:,
                                                             instrument:, status: :pending)

    login_as psychologist
    visit participant_instrument_results_path(participant_instrument)

    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content 'Concluído em'
    expect(page).not_to have_content 'Pontuação total'
    expect(page).not_to have_selector '#participant_answers'
  end
end
