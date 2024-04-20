class ParticipantInstrumentsController < ApplicationController
  def show
    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])
  end

  def new
    @participant = Participant.find(params[:participant_id])
    @participant_instrument = @participant.participant_instruments.build
    @options = Instrument.all
  end

  def create
    participant = Participant.find(params[:participant_id])
    instrument = Instrument.find(params[:participant_instrument][:instrument_id])
    participant_instrument = ParticipantInstrument.new(participant:, instrument:)

    participant_instrument.save
    ParticipantInstrumentMailer.with(participant_instrument:).notify_participant.deliver_now

    redirect_to participant, notice: t('.success')
  end
end
