class RenameUserIdFromGuesses < ActiveRecord::Migration[6.0]
  def change
    add_column :guesses, :player_id, :integer, null: false
    remove_column :guesses, :user_id
  end
end
