# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.integer :trivia_id
      t.integer :team_id

      t.timestamps
    end
  end
end
