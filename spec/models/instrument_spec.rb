require 'rails_helper'

RSpec.describe Instrument, type: :model do
  context '#valid?' do
    it 'returns false when name is empty' do
      instrument = build(:instrument, name: '')

      expect(instrument.valid?).to be false
      expect(instrument.errors).to include :name
    end

    it 'returns false when description is empty' do
      instrument = build(:instrument, description: '')

      expect(instrument.valid?).to be false
      expect(instrument.errors).to include :description
    end

    it 'returns true when all fields are valid' do
      instrument = build(:instrument, name: 'Teste de Ansiedade Geral',
                                      description: 'Avalia possível quadro de ansiedade')

      expect(instrument.valid?).to be true
      expect(instrument.errors).to be_empty
    end
  end

  it 'number of questions cannot exceed Instrument::MAX_QUESTIONS' do
    instrument = create(:instrument)

    Instrument::MAX_QUESTIONS.times { create(:question, instrument:) }

    expect { instrument.questions.create!(description: 'Questão excedente') }
      .to raise_error Instrument::QuestionsLimitExceeded
    expect(instrument.questions.count).to eq Instrument::MAX_QUESTIONS
  end
end
