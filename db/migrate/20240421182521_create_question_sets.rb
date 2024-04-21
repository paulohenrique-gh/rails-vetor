class CreateQuestionSets < ActiveRecord::Migration[7.1]
  def change
    create_table :question_sets do |t|
      t.references :participant_instrument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
