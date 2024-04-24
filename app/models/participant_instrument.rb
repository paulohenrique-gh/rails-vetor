class ParticipantInstrument < ApplicationRecord
  class ScoreAlreadyComputed < ActiveRecord::ActiveRecordError; end

  belongs_to :participant
  belongs_to :instrument

  has_many :questions, through: :instrument
  has_many :answers, dependent: :destroy
  has_one :psychologist, through: :participant

  enum status: { pending: 0, finished: 1 }

  def finished!
    return unless score

    self.finished_at = Time.zone.now
    super
  end

  def compute_score
    raise ScoreAlreadyComputed if finished?

    self.score = 0
    answers.each { |answer| self.score += answer.weight }

    finished!
  end
end
