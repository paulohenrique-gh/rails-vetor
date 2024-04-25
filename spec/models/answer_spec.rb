require 'rails_helper'

RSpec.describe Answer, type: :model do
  context '.save_answers' do
    it 'instantiate answers according to parameters' do
      participant_instrument = create(:participant_instrument)
      instrument = participant_instrument.instrument

      question1 = create(:question, instrument:)
      question2 = create(:question, instrument:)
      question3 = create(:question, instrument:)
      question4 = create(:question, instrument:)
      question5 = create(:question, instrument:)

      selected_option_for_question1 = create(:option, question: question1, weight: 2)
      selected_option_for_question2 = create(:option, question: question2, weight: 3)
      selected_option_for_question3 = create(:option, question: question3, weight: 0)
      selected_option_for_question4 = create(:option, question: question4, weight: 1)
      selected_option_for_question5 = create(:option, question: question5, weight: 3)

      selected_options = [
        selected_option_for_question1,
        selected_option_for_question2,
        selected_option_for_question3,
        selected_option_for_question4,
        selected_option_for_question5
      ]

      Answer.save_answers(options: selected_options, participant_instrument:)

      expect(participant_instrument.answers.count).to eq 5
    end
  end
end
