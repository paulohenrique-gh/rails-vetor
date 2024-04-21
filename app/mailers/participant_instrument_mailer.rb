class ParticipantInstrumentMailer < ApplicationMailer
  def notify_participant
    @participant = params[:participant_instrument].participant
    @instrument = params[:participant_instrument].instrument
    id = params[:participant_instrument].id
    @link = "http://localhost:3000/participant_instruments/#{id}/validation"

    mail(subject: t(:mail_subject), to: @participant.email)
  end
end
