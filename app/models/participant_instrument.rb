class ParticipantInstrument < ApplicationRecord
  belongs_to :participant
  belongs_to :instrument
end
