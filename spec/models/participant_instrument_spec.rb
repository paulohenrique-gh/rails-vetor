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

  context '#finished!' do
    it 'updates status when score is present' do
      participant_instrument = create(:participant_instrument, score: 8, status: :pending)

      participant_instrument.finished!

      expect(participant_instrument.status).to eq 'finished'
      expect(participant_instrument.finished_at).not_to be_nil
    end

    it 'does not update status when score is nil' do
      participant_instrument = create(:participant_instrument, score: nil, status: :pending)

      participant_instrument.finished!

      expect(participant_instrument.status).to eq 'pending'
      expect(participant_instrument.finished_at).to be_nil
    end
  end

  context '#compute_score' do
    it 'calculates score attribute according to associated answers' do
      participant_instrument = create(:participant_instrument)
      instrument = participant_instrument.instrument

      question1 = create(:question, instrument:)
      question2 = create(:question, instrument:)
      question3 = create(:question, instrument:)
      question4 = create(:question, instrument:)
      question5 = create(:question, instrument:)

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

    it 'raises error if status is finished' do
      participant_instrument = create(:participant_instrument, status: :finished)

      expect { participant_instrument.compute_score }
        .to raise_error ParticipantInstrument::ScoreAlreadyComputed
    end
  end
end
