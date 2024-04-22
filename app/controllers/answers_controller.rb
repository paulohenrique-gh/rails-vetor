class AnswersController < ApplicationController
  QUESTION_INDEXES = %w[0 1 2 3 4].freeze

  def create
    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])

    if missing_answers?
      flash[:alert] = t('.missing_answers')
      return render 'instruments/load_questionnaire', status: :bad_request
    end

    Answer.save_answers(answers: answers_params, participant_instrument: @participant_instrument)

    redirect_to instrument_completion_path
  end

  private

  def missing_answers?
    params[:answers].keys != QUESTION_INDEXES
  end

  def answers_params
    params[:answers].permit(QUESTION_INDEXES.map { |index| { index => [:option_id] } })
  end
end
