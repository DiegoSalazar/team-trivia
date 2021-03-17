class AddPlayerIdToTrivia < ActiveRecord::Migration[6.0]
  def change
    add_column :trivia, :player_id, :integer
  end
end
