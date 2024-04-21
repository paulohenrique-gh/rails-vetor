class QuestionSet < ApplicationRecord
  belongs_to :participant_instrument

  has_many :questions
end
