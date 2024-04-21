class Question < ApplicationRecord
  belongs_to :question_set

  validates :description, presence: true
end
