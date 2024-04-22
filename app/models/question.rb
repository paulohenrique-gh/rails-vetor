class Question < ApplicationRecord
  belongs_to :instrument

  has_many :options, dependent: :destroy

  validates :description, presence: true
end
