class AddPsychologistToParticipants < ActiveRecord::Migration[7.1]
  def change
    add_reference :participants, :psychologist, null: false, foreign_key: true
  end
end
