class ParticipantInstrumentsController < ApplicationController
  skip_before_action :authenticate_psychologist!, only: %i[show]

  def show
    @participant_instrument = ParticipantInstrument.find(params[:id])
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
