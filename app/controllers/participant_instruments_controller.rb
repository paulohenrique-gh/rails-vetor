class ParticipantInstrumentsController < ApplicationController
  def new
    @participant = Participant.find(params[:participant_id])
    @participant_instrument = @participant.participant_instruments.build
    @options = Instrument.all
  end
end
