class ParticipantInstrumentsController < ApplicationController
  # TODO: remove show
  before_action :authorize, only: %i[show create]

  skip_before_action :authenticate_psychologist!, only: %i[show]

  # TODO: delete action after refatoring to results controller
  def show
    @participant_instrument = ParticipantInstrument.find(params[:id])
  end

  def create
    instrument = Instrument.find(params[:participant_instrument][:instrument_id])
    participant_instrument = ParticipantInstrument.new(participant: @participant, instrument:)

    participant_instrument.save
    ParticipantInstrumentMailer.with(participant_instrument:).notify_participant.deliver_now

    redirect_to @participant, notice: t('.success')
  end

  private

  def authorize
    @participant = Participant.find(params[:participant_id])
    redirect_to root_path unless @participant.psychologist == current_psychologist
  end
end
