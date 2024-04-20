class ParticipantInstrumentsController < ApplicationController
  def new
    @participant = Participant.find(params[:participant_id])
    @participant_instrument = @participant.participant_instruments.build
    @options = Instrument.all
  end

  def create
    participant = Participant.find(params[:participant_id])
    instrument = Instrument.find(params[:participant_instrument][:instrument_id])
    participant_instrument = ParticipantInstrument.new(participant:, instrument:)

    redirect_to participant, notice: 'Instrumento aplicado com sucesso!' if participant_instrument.save
  end
end
