class ResponsesController < ApplicationController
  def create
    participant_instrument = ParticipantInstrument.find(params[:participant_instrument_id])
    form_responses = params[:responses]

    form_responses.each do |key, value|
      option = Option.find(value[:option_id])
      option.responses.create!(participant_instrument:)
    end
    
    debugger
  end
end
