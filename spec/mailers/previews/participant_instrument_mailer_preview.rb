class ParticipantInstrumentMailerPreview < ActionMailer::Preview
  def notify_participant
    # TODO: handle error that occurs if there is no ParticipantInstrument in the database
    participant_instrument = ParticipantInstrument.pending.last || ParticipantInstrument.finished.last

    ParticipantInstrumentMailer.with(participant_instrument:).notify_participant
  end
end
