class ParticipantInstrument < ApplicationRecord
  belongs_to :participant
  belongs_to :instrument

  has_one :question_set
  has_many :questions, through: :question_set
  has_many :answers

  enum status: { pending: 0, finished: 1 }

  def finished!
    super if score
  end

  def compute_score
    raise 'Score already computed' if finished? 
    self.score = 0
    self.answers.each { |answer| self.score += answer.weight }

    finished!
  end
end
