class Participant < ApplicationRecord
  has_many :participant_instruments, dependent: :destroy
  has_many :instruments, through: :participant_instruments

  validates :name, :cpf, :email, :date_of_birth, presence: true
  validates :cpf, :email, uniqueness: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  validate :validate_cpf

  def valid_data?(data)
    symbolized_data = data.to_h.symbolize_keys

    name.downcase == symbolized_data[:name].downcase &&
    cpf.gsub(/[^\d]/, '') == symbolized_data[:cpf].gsub(/[^\d]/, '') &&
    email.downcase == symbolized_data[:email].downcase &&
    date_of_birth.to_date == symbolized_data[:date_of_birth].to_date
  end

  private

  def validate_cpf
    errors.add(:cpf, I18n.t(:invalid_cpf)) unless cpf.blank? || CPF.valid?(cpf)
  end
end
