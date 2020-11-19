# frozen_string_literal: true

class CreateJoins < ActiveRecord::Migration[6.0]
  def change
    create_table :joins do |t|
      t.integer :player_id
      t.integer :team_id

      t.timestamps
    end
  end
end
