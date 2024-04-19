class Participant < ApplicationRecord
  # TODO: change unique index for cpf and email

  validates :name, :cpf, :email, :date_of_birth, presence: true
  validates :cpf, :email, uniqueness: true
end
