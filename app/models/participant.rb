class Participant < ApplicationRecord
  validates :name, :cpf, :email, :date_of_birth, presence: true
  validates :cpf, :email, uniqueness: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  validate :validate_cpf

  private

  def validate_cpf
    errors.add(:cpf, I18n.t(:already_exists)) unless cpf.blank? || CPF.valid?(cpf)
  end
end
