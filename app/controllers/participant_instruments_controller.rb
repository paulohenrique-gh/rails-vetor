class ParticipantInstrumentsController < ApplicationController
  def show
    validate_status 
   
    # TODO: change this action to instrument#show
    unless participant_validated?
      return redirect_to participant_instrument_validation_path(params[:id]),
                         alert: t('.participant_not_validated')
    end

    @participant_instrument = ParticipantInstrument.find(params[:id])
  end

  def new
    @participant = Participant.find(params[:participant_id])
    @participant_instrument = @participant.participant_instruments.build
    @options = Instrument.all
  end

  def create
    participant = Participant.find(params[:participant_id])
    instrument = Instrument.find(params[:participant_instrument][:instrument_id])
    participant_instrument = ParticipantInstrument.new(participant:, instrument:)

    participant_instrument.save
    ParticipantInstrumentMailer.with(participant_instrument:).notify_participant.deliver_now

    redirect_to participant, notice: t('.success')
  end

  def validation
    @participant = Participant.new
  end

  def validate_participant
    participant = ParticipantInstrument.find(params[:participant_instrument_id]).participant

    if participant.valid_data?(submitted_participant_data)
      store_validation
      return redirect_to participant_instrument_path(params[:participant_instrument_id])
    end

    flash.now[:alert] = t('.incorrect_data')
    render :validation, status: :unauthorized
  end

  def completion; end

  private

  # def set_participant_instrument
  #   @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])
  # end

  def validate_status
    participant_instrument = ParticipantInstrument.find(params[:id])
    if participant_instrument.finished?
      redirect_to instrument_completion_path, notice: 'Questionário já submetido' 
    end
  end

  def submitted_participant_data
    params.require(:participant).permit(:name, :cpf, :email, :date_of_birth)
  end

  def store_validation
    session[:participant_validated] = true
  end

  def participant_validated?
    session[:participant_validated]
  end
end
