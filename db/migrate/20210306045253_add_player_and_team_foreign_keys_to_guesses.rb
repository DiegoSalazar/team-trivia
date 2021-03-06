class AddPlayerAndTeamForeignKeysToGuesses < ActiveRecord::Migration[6.0]
  def change
    add_column :guesses, :player_id, :integer
    add_column :guesses, :team_id, :integer
    add_column :guesses, :trivium_id, :integer
    add_index :guesses, %i[trivium_id team_id]
    add_index :guesses, %i[trivium_id player_id]
  end
end
