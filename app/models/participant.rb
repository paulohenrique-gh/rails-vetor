class Participant < ApplicationRecord
  has_many :participant_instruments, dependent: :destroy
  has_many :instruments, through: :participant_instruments

  validates :name, :cpf, :email, :date_of_birth, presence: true
  validates :cpf, :email, uniqueness: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  validate :validate_cpf

  private

  def validate_cpf
    errors.add(:cpf, I18n.t(:invalid_cpf)) unless cpf.blank? || CPF.valid?(cpf)
  end
end
