class Answer < ApplicationRecord
  belongs_to :participant_instrument
  belongs_to :option
end
