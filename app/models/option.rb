class Option < ApplicationRecord
  belongs_to :question

  has_many :answers

  validates :description, :weight, presence: true
end
