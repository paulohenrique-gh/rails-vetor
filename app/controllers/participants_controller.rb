class ParticipantsController < ApplicationController
  def show
    @participant = Participant.find(params[:id])
  end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)

    return redirect_to @participant, notice: t('.success') if @participant.save

    flash[:alert] = "#{t('.failure')} #{@participant.errors.full_messages.to_sentence}"
    render :new, status: :unprocessable_entity
  end

  def validation
    @participant = Participant.new
  end

  def validate_participant
    @participant = ParticipantInstrument.find(params[:participant_instrument_id]).participant

    if @participant.valid_data?(participant_params)
      store_validation
      return redirect_to participant_instrument_questionnaire_path(params[:participant_instrument_id])
    end

    flash.now[:alert] = t('.incorrect_data')
    render :validation, status: :unauthorized
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :cpf, :email, :date_of_birth)
  end

  def store_validation
    session[:participant_validated] = true
  end
end
