class InstrumentsController < ApplicationController
  def load_questionnaire
    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])
    validate_status

    unless participant_validated?
      return redirect_to participant_instrument_validation_path(params[:participant_instrument_id]),
                         alert: t('.participant_not_validated')
    end
  end

  private

  def validate_status
    return unless @participant_instrument.finished?

    redirect_to instrument_completion_path, notice: 'Questionário já submetido'
  end

  def participant_validated?
    session[:participant_validated]
  end
end
