class AddConstraintsToTrivia < ActiveRecord::Migration[6.0]
  def change
    change_column_null :trivia, :title, false
    change_column_null :trivia, :body, false
    change_column_null :trivia, :game_starts_at, false
    change_column_null :trivia, :game_ends_at, false
    change_column_default :trivia, :questions_count, from: nil, to: 0
    change_column_default :trivia, :likes_count, from: nil, to: 0
  end
end
