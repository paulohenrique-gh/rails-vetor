class Participant < ApplicationRecord
  belongs_to :psychologist

  has_many :participant_instruments, dependent: :destroy
  has_many :instruments, through: :participant_instruments

  before_validation :sanitize_cpf

  validate :validate_cpf

  validates :name, :cpf, :email, :date_of_birth, presence: true
  validates :cpf, :email, uniqueness: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  def valid_data?(data)
    symbolized_data = data.to_h.symbolize_keys

    same_name?(symbolized_data[:name]) &&
      same_cpf?(symbolized_data[:cpf]) &&
      same_email?(symbolized_data[:email]) &&
      same_date_of_birth?(symbolized_data[:date_of_birth])
  end

  private

  def sanitize_cpf
    cpf.gsub!(/[^\d]/, '')
  end

  def validate_cpf
    errors.add(:cpf, I18n.t(:invalid_cpf)) unless cpf.blank? || CPF.valid?(cpf)
  end

  def same_name?(name_to_compare)
    name.downcase == name_to_compare.downcase
  end

  def same_cpf?(cpf_to_compare)
    cpf.gsub(/[^\d]/, '') == cpf_to_compare.gsub(/[^\d]/, '')
  end

  def same_email?(email_to_compare)
    email.downcase == email_to_compare.downcase
  end

  def same_date_of_birth?(date_of_birth_to_compare)
    date_of_birth.to_date == date_of_birth_to_compare.to_date
  end

  # TODO: sanitize cpf
end
