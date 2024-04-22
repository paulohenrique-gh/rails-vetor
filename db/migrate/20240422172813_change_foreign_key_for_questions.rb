class ChangeForeignKeyForQuestions < ActiveRecord::Migration[7.1]
  def change
    remove_reference :questions, :question_set, foreign_key: true
    add_reference :questions, :instrument, null: false, foreign_key: true
  end
end
