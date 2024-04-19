require 'rails_helper'

RSpec.describe Participant, type: :model do
  context '#valid?' do
    it 'returns false when name is empty' do
      participant = build(:participant, name: '')

      expect(participant.valid?).to be false
      expect(participant.errors).to include :name
    end

    it 'returns false when cpf is empty' do
      participant = build(:participant, cpf: '')

      expect(participant.valid?).to be false
      expect(participant.errors).to include :cpf
    end

    it 'returns false when email is empty' do
      participant = build(:participant, email: '')

      expect(participant.valid?).to be false
      expect(participant.errors).to include :email
    end

    it 'returns false when date of birth is empty' do
      participant = build(:participant, date_of_birth: '')

      expect(participant.valid?).to be false
      expect(participant.errors).to include :date_of_birth
    end

    it 'returns false when cpf already exists in the database' do
      create(:participant, email: 'email@mail.com', cpf: '934.681.720-87')
      new_participant = build(:participant, email: 'diferente@mail.com', cpf: '934.681.720-87')

      expect(new_participant.valid?).to be false
      expect(new_participant.errors).to include :cpf
    end

    it 'returns false when email already exists in the database' do
      create(:participant, email: 'mesmoemail@mail.com', cpf: '198.079.260-76')
      new_participant = build(:participant, email: 'mesmoemail@mail.com', cpf: '577.153.480-31')

      expect(new_participant.valid?).to be false
      expect(new_participant.errors).to include :email
    end
  end
end
