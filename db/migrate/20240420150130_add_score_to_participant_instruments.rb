class AddScoreToParticipantInstruments < ActiveRecord::Migration[7.1]
  def change
    add_column :participant_instruments, :score, :integer
  end
end
