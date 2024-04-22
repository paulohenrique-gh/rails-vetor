class AnswersController < ApplicationController
  QUESTION_INDEXES = ['0', '1', '2', '3', '4'].freeze

  def create
    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])

    if missing_answers?
      flash[:alert] = 'É necessário selecionar uma opção para cada pergunta'
      return render 'participant_instruments/show', status: :bad_request
    end

    @form_responses = params[:responses]
    
    # TODO: compute score and save it to participant_instrument.score
    redirect_to instrument_completion_path
  end

  private

  def missing_answers?
    params[:responses].keys != QUESTION_INDEXES
  end

  def instantiate_answers
    @form_responses.each do |_, value|
      option = Option.find(value[:option_id])
      option.answers.create!(participant_instrument:)
    end
  end
end
