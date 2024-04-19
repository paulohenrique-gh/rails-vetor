FactoryBot.define do
  factory :participant do
    name { 'João Lúcio de Castro' }
    cpf { '715.229.040-77' }
    email { 'joao@email.com' }
    date_of_birth { '1999-05-23' }
  end
end
