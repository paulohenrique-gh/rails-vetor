require 'rails_helper'

RSpec.describe ParticipantInstrument, type: :model do
  context '#valid' do
    it 'returns false with no associated participant' do
      instrument = create(:instrument)
      participant_instrument = build(:participant_instrument, instrument:)

      expect(participant_instrument.valid?).to be false
      expect(participant_instrument.errors).to include :participant
    end

    it 'returns false with no associated instrument' do
      participant = create(:participant)
      participant_instrument = build(:participant_instrument, participant:)

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
end
