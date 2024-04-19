class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :email, null: false
      t.date :date_of_birth, null: false

      t.timestamps

      t.index [:cpf, :email], unique: true
    end
  end
end
