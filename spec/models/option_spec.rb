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

    it 'returns false when weight is more than 3' do
      option = build(:option, weight: 5)

      expect(option.valid?).to eq false
      expect(option.errors).to include :weight
    end

    it 'returns false when weight is less than 0' do
      option = build(:option, weight: -3)

      expect(option.valid?).to eq false
      expect(option.errors).to include :weight
    end

    it 'returns false when associated question has option with the same weight' do
      question = create(:question)
      option = create(:option, question:, weight: 2)
      new_option = build(:option, question:, weight: 2)

      expect(new_option.valid?).to eq false
      expect(new_option.errors).to include :weight
    end
  end
end
