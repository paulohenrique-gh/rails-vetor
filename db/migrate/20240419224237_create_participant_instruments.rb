class CreateParticipantInstruments < ActiveRecord::Migration[7.1]
  def change
    create_table :participant_instruments do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :instrument, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
