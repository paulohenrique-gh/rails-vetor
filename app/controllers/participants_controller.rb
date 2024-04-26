class ParticipantsController < ApplicationController
  before_action :authorize, only: %i[show]

  skip_before_action :authenticate_psychologist!, only: %i[validation validate_participant]

  def show
    @options_for_new_instruments = Instrument.all
  end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.psychologist = current_psychologist

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

  def authorize
    @participant = Participant.find(params[:id])
    redirect_to root_path unless @participant.psychologist == current_psychologist
  end

  def participant_params
    params.require(:participant).permit(:name, :cpf, :email, :date_of_birth)
  end

  def store_validation
    session[:participant_validated] = true
  end
end
