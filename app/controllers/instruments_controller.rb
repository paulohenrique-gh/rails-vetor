class InstrumentsController < ApplicationController
  before_action :set_participant_instrument, only: %i[load_questionnaire validate_participant]

  def load_questionnaire
    validate_status

    unless participant_validated?
      return redirect_to participant_instrument_validation_path(params[:participant_instrument_id]),
                         alert: t('.participant_not_validated')
    end
  end

  def validation
    @participant = Participant.new
  end

  def validate_participant
    participant = @participant_instrument.participant

    if participant.valid_data?(participant_params)
      store_validation
      return redirect_to instrument_questionnaire_path(params[:participant_instrument_id])
    end

    flash.now[:alert] = t('.incorrect_data')
    render :validation, status: :unauthorized
  end

  def completion; end
  
  private

  def set_participant_instrument
    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])
  end

  def participant_params
    params.require(:participant).permit(:name, :cpf, :email, :date_of_birth)
  end

  def validate_status
    return unless @participant_instrument.finished?

    redirect_to instrument_completion_path, notice: 'Questionário já submetido'
  end

  def store_validation
    session[:participant_validated] = true
  end

  def participant_validated?
    session[:participant_validated]
  end
end
