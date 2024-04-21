class Question < ApplicationRecord
  belongs_to :question_set

  has_many :options

  validates :description, presence: true
end
