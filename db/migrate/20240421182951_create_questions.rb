class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :description, null: false
      t.references :question_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
