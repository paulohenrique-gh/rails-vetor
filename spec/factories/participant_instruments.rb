FactoryBot.define do
  factory :participant_instrument do
    participant
    instrument
    status { 0 }
  end
end
