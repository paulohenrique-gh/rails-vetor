class ParticipantInstrument < ApplicationRecord
  belongs_to :participant
  belongs_to :instrument

  enum status: { pending: 0, finished: 1 }
end
