require 'rails_helper'

RSpec.describe ParticipantInstrumentMailer, type: :mailer do
  context '#notify_participant' do
    it 'sends email with link to instrument' do
      participant = create(:participant, name: 'Carlos Eduardo Batista',
                                         email: 'eduardo@email.com')
      instrument = create(:instrument)
      participant_instrument = participant.participant_instruments.create!(instrument:)

      mail = ParticipantInstrumentMailer.with(participant_instrument:).notify_participant

      expect(mail.subject).to eq 'Vetor - Novo Questionário'
      expect(mail.to.size).to eq 1
      expect(mail.to).to include participant.email
      expect(mail.body).to include 'Olá, <strong>Carlos Eduardo Batista</strong>'
      expect(mail.body).to include 'Você tem um novo questionário pendente.'
      link = "http://localhost:3000#{participant_instruments_path(participant_instrument)}"
      expect(mail.body).to include(
        "Clique <a href=\"#{link}\">aqui</a> para acessar."
      )
    end
  end
end
