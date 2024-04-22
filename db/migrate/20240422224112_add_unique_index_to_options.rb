class AddUniqueIndexToOptions < ActiveRecord::Migration[7.1]
  def change
    add_index :options, [:weight, :question_id], unique: true
  end
end
