class AddGuessIdToTeamMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :team_messages, :guess_id, :integer
  end
end
