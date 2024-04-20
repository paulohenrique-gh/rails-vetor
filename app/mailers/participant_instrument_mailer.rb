class ParticipantInstrumentMailer < ApplicationMailer
  def notify_participant
    @participant = params[:participant_instrument].participant
    @instrument = params[:participant_instrument].instrument
    @participant_instrument_id = params[:participant_instrument].id
    @link = "http://localhost:3000/participant_instruments/#{@participant_instrument_id}"

    mail(subject: t(:mail_subject), to: @participant.email)
  end
end
