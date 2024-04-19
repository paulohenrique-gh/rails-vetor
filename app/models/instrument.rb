class Instrument < ApplicationRecord
  has_many :participant_instruments, dependent: :destroy

  validates :name, :description, presence: true
end
