class Instrument < ApplicationRecord
  class QuestionsLimitExceeded < ActiveRecord::ActiveRecordError; end

  MAX_QUESTIONS = 5

  has_many :participant_instruments, dependent: :destroy
  has_many :questions, dependent: :destroy, before_add: :check_questions_limit

  validates :name, :description, presence: true

  private

  def check_questions_limit(_question)
    raise QuestionsLimitExceeded if questions.count >= MAX_QUESTIONS 
  end
end
