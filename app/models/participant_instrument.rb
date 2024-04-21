class ParticipantInstrument < ApplicationRecord
  belongs_to :participant
  belongs_to :instrument

  has_one :question_set
  has_many :questions, through: :question_set

  enum status: { pending: 0, finished: 1 }
end
