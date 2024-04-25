class InstrumentsController < ApplicationController
  skip_before_action :authenticate_psychologist!, only: %i[load_questionnaire completion]

  def load_questionnaire
    unless participant_validated?
      return redirect_to participant_instrument_validation_path(params[:participant_instrument_id])
    end

    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])
    redirect_finished_instrument
  end

  def completion; end

  private

  def redirect_finished_instrument
    return if @participant_instrument.pending?

    redirect_to instrument_completion_path, notice: t('.already_submitted')
  end

  def participant_validated?
    session[:participant_validated]
  end
end
