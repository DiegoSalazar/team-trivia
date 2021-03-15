class AddTeamIdToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :team_id, :integer
  end
end
