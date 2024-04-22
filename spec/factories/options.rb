FactoryBot.define do
  factory :option do
    sequence(:description) { |n| "Option #{n}" }
    weight { 1 }
    question
  end
end
