class DropQuestionSets < ActiveRecord::Migration[7.1]
  def change
    drop_table :question_sets
  end
end
