class Answer < ApplicationRecord
  belongs_to :participant_instrument
  belongs_to :option

  delegate :weight, to: :option

  def self.save_answers(answers:, participant_instrument:)
    answers.each do |_, answer|
      option = Option.find(answer[:option_id])
      create!(option:, participant_instrument:)
    end

    participant_instrument.compute_score
  end
end
