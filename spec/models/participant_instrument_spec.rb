require 'rails_helper'

RSpec.describe ParticipantInstrument, type: :model do
  context '#valid' do
    it 'returns false with no associated participant' do
      instrument = create(:instrument)
      participant_instrument = build(:participant_instrument, instrument:, participant: nil)

      expect(participant_instrument.valid?).to be false
      expect(participant_instrument.errors).to include :participant
    end

    it 'returns false with no associated instrument' do
      participant = create(:participant)
      participant_instrument = build(:participant_instrument, participant:, instrument: nil)

      expect(participant_instrument.valid?).to be false
      expect(participant_instrument.errors).to include :instrument
    end

    it 'returns true when all associations are present' do
      participant = create(:participant)
      instrument = create(:instrument)
      participant_instrument = build(:participant_instrument, participant:, instrument:)

      expect(participant_instrument.valid?).to be true
      expect(participant_instrument.errors).to be_empty
    end
  end

  pending '#finished!'

  context '#compute_score' do
    it 'calculates score attribute according to associated answers' do
      participant_instrument = create(:participant_instrument)
      question_set = create(:question_set, participant_instrument:)

      question1 = create(:question, question_set:)
      question2 = create(:question, question_set:)
      question3 = create(:question, question_set:)
      question4 = create(:question, question_set:)
      question5 = create(:question, question_set:)

      selected_option_for_question1 = create(:option, question: question1, weight: 2)
      selected_option_for_question2 = create(:option, question: question2, weight: 3)
      selected_option_for_question3 = create(:option, question: question3, weight: 0)
      selected_option_for_question4 = create(:option, question: question4, weight: 1)
      selected_option_for_question5 = create(:option, question: question5, weight: 3)

      create(:answer, participant_instrument:, option: selected_option_for_question1)
      create(:answer, participant_instrument:, option: selected_option_for_question2)
      create(:answer, participant_instrument:, option: selected_option_for_question3)
      create(:answer, participant_instrument:, option: selected_option_for_question4)
      create(:answer, participant_instrument:, option: selected_option_for_question5)

      participant_instrument.compute_score

      expect(participant_instrument.score).to eq 9
    end
  end
end
