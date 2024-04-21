require 'rails_helper'

RSpec.describe Question, type: :model do
  context '#valid?' do
    it 'returns false when description is empty' do
      participant = create(:participant)
      instrument = create(:instrument)
      participant_instrument = participant.participant_instruments.create!(instrument:)
      question_set = participant_instrument.create_question_set
      question = build(:question, description: '', question_set:)

      expect(question.valid?).to be false
      expect(question.errors).to include :description
    end

    it 'returns false when not associated with a question_set' do
      question = build(:question, description: 'Descrição da questão', question_set: nil)

      expect(question.valid?).to be false
      expect(question.errors).to include :question_set
    end

    it 'returns true when all fields are valid' do
      participant = create(:participant)
      instrument = create(:instrument)
      participant_instrument = participant.participant_instruments.create!(instrument:)
      question_set = participant_instrument.create_question_set
      question = build(:question, description: 'Descrição da questão', question_set:)

      expect(question.valid?).to be true
      expect(question.errors).to be_empty
    end
  end
end
