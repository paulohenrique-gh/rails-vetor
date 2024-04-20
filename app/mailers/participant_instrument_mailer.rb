class ParticipantInstrumentMailer < ApplicationMailer
  def notify_participant
    @participant = params[:participant_instrument].participant
    @instrument = params[:participant_instrument].instrument
    
    mail(subject: 'Novo Questionário', to: @participant.email)
  end
end
