class ParticipantsController < ApplicationController
  def show; end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.save

    redirect_to @participant, notice: t('.success')
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :cpf, :email, :date_of_birth)
  end
end
