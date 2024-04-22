require 'rails_helper'

RSpec.describe Question, type: :model do
  context '#valid?' do
    it 'returns false when description is empty' do
      participant_instrument = create(:participant_instrument)
      instrument = participant_instrument.instrument
      question = build(:question, description: '', instrument:)

      expect(question.valid?).to be false
      expect(question.errors).to include :description
    end

    it 'returns false when not associated with a question_set' do
      question = build(:question, description: 'Descrição da questão', instrument: nil)

      expect(question.valid?).to be false
      expect(question.errors).to include :instrument
    end

    it 'returns true when all fields are valid' do
      instrument = create(:instrument)
      question = build(:question, description: 'Descrição da questão', instrument:)

      expect(question.valid?).to be true
      expect(question.errors).to be_empty
    end
  end

  context '.options' do
    it 'returns options sorted by weight in descending order' do
      question = create(:question)

      create(:option, weight: 1, question:)
      create(:option, weight: 2, question:)
      create(:option, weight: 0, question:)
      create(:option, weight: 3, question:)

      expected_result = question.options.order(weight: :desc)

      expect(question.options).to eq expected_result
    end
  end

  it 'number of options cannot exceed 4' do
    question = create(:question)

    4.times { create(:option, question:) }

    expect { question.options.create!(description: 'Questão 5', weight: 3) }
      .to raise_error Question::OptionsLimitExceeded
    expect(question.options.count).to eq 4
  end
end
