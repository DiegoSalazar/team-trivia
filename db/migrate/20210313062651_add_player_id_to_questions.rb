class AddPlayerIdToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :player_id, :integer
  end
end
