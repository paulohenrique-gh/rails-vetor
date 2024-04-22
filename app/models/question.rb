class Question < ApplicationRecord
  class OptionsLimitExceeded < ActiveRecord::ActiveRecordError; end
  
  MAX_OPTIONS = 4

  belongs_to :instrument

  has_many :options, -> { order(weight: :desc) }, dependent: :destroy, before_add: :check_options_limit

  validates :description, presence: true

  private

  def check_options_limit(_option)
    raise OptionsLimitExceeded if options.count == MAX_OPTIONS
  end
end
