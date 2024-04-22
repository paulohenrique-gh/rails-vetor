class Question < ApplicationRecord
  belongs_to :instrument

  has_many :options, -> { order(weight: :desc) }, dependent: :destroy

  validates :description, presence: true
end
