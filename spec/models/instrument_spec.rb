require 'rails_helper'

RSpec.describe Instrument, type: :model do
  context '#valid?' do
    it 'returns false when name is empty' do
      instrument = build(:instrument, name: '')

      expect(instrument.valid?).to be false
      expect(instrument.errors).to include :name
    end

    it 'returns false when description is empty' do
      instrument = build(:instrument, description: '')

      expect(instrument.valid?).to be false
      expect(instrument.errors).to include :description
    end
  end
end
