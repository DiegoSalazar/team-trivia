class RenameMesssagesToTeamMessages < ActiveRecord::Migration[6.0]
  def change
    rename_table :messages, :team_messages
  end
end
