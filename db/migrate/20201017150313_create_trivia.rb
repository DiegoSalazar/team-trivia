# frozen_string_literal: true

class CreateTrivia < ActiveRecord::Migration[6.0]
  def change
    create_table :trivia do |t|
      t.text :title
      t.text :body
      t.datetime :game_starts_at
      t.datetime :game_ends_at
      t.integer :questions_count
      t.integer :likes_count

      t.timestamps
    end
  end
end
