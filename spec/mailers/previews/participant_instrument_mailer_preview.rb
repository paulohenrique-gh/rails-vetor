class ParticipantInstrumentMailerPreview < ActionMailer::Preview
  def notify_participant
    participant_instrument = ParticipantInstrument.pending.last

    ParticipantInstrumentMailer.with(participant_instrument:).notify_participant
  end
end
