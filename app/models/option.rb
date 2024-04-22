class Option < ApplicationRecord
  WEIGHT_RANGE = 0..3

  belongs_to :question

  has_many :answers, dependent: :destroy

  validates :description, :weight, presence: true
  validates :weight, numericality: { in: WEIGHT_RANGE }, uniqueness: { scope: :question }
end
