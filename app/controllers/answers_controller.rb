class AnswersController < ApplicationController
  skip_before_action :authenticate_psychologist!, only: %i[create]

  QUESTION_INDEXES = (0...Instrument::MAX_QUESTIONS).to_a.map(&:to_s)

  def create
    @participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])

    if missing_answers?
      flash[:alert] = t('.missing_answers')
      return render 'instruments/load_questionnaire', status: :bad_request
    end

    Answer.save_answers(options: options_from_params, participant_instrument: @participant_instrument)
    clear_session

    redirect_to instrument_completion_path
  end

  private

  def missing_answers?
    params[:answers]&.keys != QUESTION_INDEXES
  end

  def answers_params
    params[:answers].permit(QUESTION_INDEXES.map { |index| { index => :option_id } })
  end

  def options_from_params
    Option.find(answers_params.values.map { |a| a[:option_id] })
  end

  def clear_session
    session[:participant_validated] = nil
  end
end
