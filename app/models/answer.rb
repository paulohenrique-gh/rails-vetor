class Answer < ApplicationRecord
  belongs_to :participant_instrument
  belongs_to :option

  has_one :question, through: :option

  delegate :weight, to: :option

  def self.save_answers(options:, participant_instrument:)
    options.each { |option| create!(option:, participant_instrument:) }

    participant_instrument.compute_score
  end
end
