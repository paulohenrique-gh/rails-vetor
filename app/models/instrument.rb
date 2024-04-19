class Instrument < ApplicationRecord
  validates :name, :description, presence: true
end
