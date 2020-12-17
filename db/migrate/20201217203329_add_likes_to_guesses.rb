class AddLikesToGuesses < ActiveRecord::Migration[6.0]
  def change
    add_column :guesses, :likes, :integer, default: 0
  end
end
