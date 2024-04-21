require 'rails_helper'

RSpec.describe QuestionSet, type: :model do
  context '#valid?' do
    it 'returns false if not associated with a participant_instrument' do
      question_set = build(:question_set, participant_instrument: nil)

      expect(question_set.valid?).to be false
      expect(question_set.errors).to include :participant_instrument
    end

    it 'returns true when associated with a participant_instrument' do
      participant = create(:participant)
      instrument = create(:instrument)
      participant_instrument = participant.participant_instruments.create!(instrument:)
      question_set = participant_instrument.build_question_set

      expect(question_set.valid?).to be true
    end
  end
end
