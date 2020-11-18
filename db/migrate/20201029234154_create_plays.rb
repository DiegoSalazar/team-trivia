# frozen_string_literal: true

class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.integer :trivia_id
      t.integer :team_id
      t.integer :submission_id

      t.timestamps
    end
  end
end
