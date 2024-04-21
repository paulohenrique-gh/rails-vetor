class Option < ApplicationRecord
  belongs_to :question

  validates :description, :weight, presence: true
end
