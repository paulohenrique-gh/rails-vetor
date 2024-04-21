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

    it 'returns false when cpf is invalid' do
      participant = build(:participant, cpf: '111222333444555')

      expect(participant.valid?).to be false
      expect(participant.errors).to include :cpf
    end

    it 'returns false when email is invalid' do
      participant = build(:participant, email: 'emailinvalido')

      expect(participant.valid?).to be false
      expect(participant.errors).to include :email
    end

    it 'returns true when all fields are valid' do
      participant = build(:participant, name: 'Pedro Martins', cpf: '163.375.600-94',
                                        email: 'pedro@martins.com', date_of_birth: '1997-10-14')

      expect(participant.valid?).to be true
      expect(participant.errors).to be_empty
    end
  end

  context '#valid_data?' do
    it 'returns false when data submitted is invalid' do
      invalid_data = { name: 'Carlos Barbosa', cpf: '00099988877',
                       email: 'carlos@email.com', date_of_birth: '20/11/1989' }
      participant = build(:participant, name: 'Luiz Daniel', cpf: '59551881001',
                                        email: 'luiz@email.com', date_of_birth: '14/04/2001')

      result = participant.valid_data?(invalid_data)

      expect(result).to be false
    end

    it 'returns true when data is the valid' do
      valid_data = { name: 'LUIZ DANIEL', cpf: '595.518.810-01',
                     email: 'luiz@email.com', date_of_birth: '14/04/2001' }
      participant = build(:participant, name: 'Luiz Daniel', cpf: '59551881001',
                                        email: 'luiz@email.com', date_of_birth: '14/04/2001')

      result = participant.valid_data?(valid_data)

      expect(result).to be true
    end
  end
end
