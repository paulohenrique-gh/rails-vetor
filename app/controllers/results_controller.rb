class ResultsController < ApplicationController
  before_action :authorize, only: %i[show]

  def show; end

  private

  def authorize
    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])
    redirect_to root_path unless @participant_instrument.psychologist == current_psychologist
  end
end
