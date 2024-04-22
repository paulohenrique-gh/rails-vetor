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
end
