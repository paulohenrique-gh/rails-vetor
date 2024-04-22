require 'rails_helper'

describe 'Participant accesses instrument questions page' do
  it 'and questions and options are displayed correctly' do
    question_set = create(:question_set)

    5.times do |qtn|
      question = create(:question, description: "Questão #{qtn + 1}", question_set:)
      4.times do |opt|
        create(:option, description: "Opção #{opt + 1} da questão #{qtn + 1}", question:)
      end
    end

    allow_any_instance_of(InstrumentsController)
      .to receive(:participant_validated?)
      .and_return(true)

    visit participant_instrument_questionnaire_path(question_set.participant_instrument)

    5.times do |idx|
      within "#question#{idx + 1}" do
        option_form_values = all('input[type="radio"]').map(&:value)
        option_ids = Question.all[idx].options.map { |opt| opt.id.to_s }
        expect(option_form_values).to eq option_ids

        option_form_labels = all('label').map(&:text)
        option_descriptions = Question.all[idx].options.map(&:description)
        expect(option_form_labels).to eq option_descriptions
      end
    end

    expect(page).to have_button 'Salvar'
  end

  it 'and answers all questions' do
    participant_instrument = create(:participant_instrument)
    question_set = create(:question_set, participant_instrument:)

    5.times do |qtn|
      question = create(:question, description: "Questão #{qtn + 1}", question_set:)
      4.times do |opt|
        create(:option, description: "Opção #{opt + 1} da questão #{qtn + 1}", question:)
      end
    end

    allow_any_instance_of(InstrumentsController)
      .to receive(:participant_validated?)
      .and_return(true)

    visit participant_instrument_questionnaire_path(participant_instrument)

    within '#question1' do
      find(:label, 'Opção 2 da questão 1').click
    end

    within '#question2' do
      find(:label, 'Opção 4 da questão 2').click
    end

    within '#question3' do
      find(:label, 'Opção 1 da questão 3').click
    end

    within '#question4' do
      find(:label, 'Opção 1 da questão 4').click
    end

    within '#question5' do
      find(:label, 'Opção 3 da questão 5').click
    end

    click_on 'Salvar'

    expect(page).to have_content 'Respostas salvas com sucesso!'
    expect(page).to have_content 'Obrigado por responder ao questionário.'
    expect(Answer.count).to eq 5
    expect(participant_instrument.reload.status).to eq 'finished'
  end

  it 'and submits form without answering all questions' do
    question_set = create(:question_set)

    5.times do |qtn|
      question = create(:question, description: "Questão #{qtn + 1}", question_set:)
      4.times do |opt|
        create(:option, description: "Opção #{opt + 1} da questão #{qtn + 1}", question:)
      end
    end

    allow_any_instance_of(InstrumentsController)
      .to receive(:participant_validated?)
      .and_return(true)

    visit participant_instrument_questionnaire_path(question_set.participant_instrument)

    within '#question2' do
      find(:label, 'Opção 4 da questão 2').click
    end

    within '#question3' do
      find(:label, 'Opção 1 da questão 3').click
    end

    click_on 'Salvar'

    expect(page).to have_content 'É necessário selecionar uma opção para cada pergunta'
    expect(Answer.count).to eq 0
  end

  it 'and it was already submitted' do
    participant_instrument = create(:participant_instrument, status: :finished)

    allow_any_instance_of(InstrumentsController)
      .to receive(:participant_validated?)
      .and_return(true)

    visit participant_instrument_questionnaire_path(participant_instrument)

    expect(page).to have_content 'Questionário já submetido'
  end
end
