FactoryBot.define do
  factory :psychologist do
    sequence(:email) { |n| "psicologo#{n}@email.com" }
    password { 'password' }
  end
end
