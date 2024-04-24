class ParticipantInstrumentMailerPreview < ActionMailer::Preview
  def notify_participant
    participant_instrument = ParticipantInstrument.pending.last || ParticipantInstrument.finished.last

    ParticipantInstrumentMailer.with(participant_instrument:).notify_participant
  end
end
