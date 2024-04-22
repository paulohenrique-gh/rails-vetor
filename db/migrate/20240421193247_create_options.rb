class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.text :description, null: false
      t.integer :weight, null: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
