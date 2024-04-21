require 'rails_helper'

RSpec.describe Option, type: :model do
  context '#valid?' do
    it 'returns false when description is empty' do
      option = build(:option, description: '')

      expect(option.valid?).to eq false
      expect(option.errors).to include :description
    end

    it 'returns false when weight is not defined' do
      option = build(:option, weight: nil)

      expect(option.valid?).to eq false
      expect(option.errors).to include :weight
    end

    it 'returns false when not associated with a question' do
      option = build(:option, question: nil)

      expect(option.valid?).to eq false
      expect(option.errors).to include :question
    end

    # TODO: is testing associations necessary?
  end
end
