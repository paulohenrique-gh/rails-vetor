class ParticipantsController < ApplicationController
  def show; end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)

    return redirect_to @participant, notice: t('.success') if @participant.save

    flash[:alert] = "#{t('.failure')} #{@participant.errors.full_messages.to_sentence}"
    render :new, status: :unprocessable_entity
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :cpf, :email, :date_of_birth)
  end
end
