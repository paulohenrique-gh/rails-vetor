class ParticipantInstrument < ApplicationRecord
  class ScoreAlreadyComputed < ActiveRecord::ActiveRecordError; end

  belongs_to :participant
  belongs_to :instrument

  has_many :questions, through: :instrument
  has_many :answers

  enum status: { pending: 0, finished: 1 }

  def finished!
    if score
      self.finished_at = Time.zone.now
      super
    end
  end

  def compute_score
    raise ScoreAlreadyComputed if finished? 
    self.score = 0
    self.answers.each { |answer| self.score += answer.weight }

    finished!
  end
end
