class ChangeUniqueIndexInParticipants < ActiveRecord::Migration[7.1]
  def change
    remove_index :participants, [:cpf, :email]

    add_index :participants, :cpf, unique: true
    add_index :participants, :email, unique: true
  end
end
