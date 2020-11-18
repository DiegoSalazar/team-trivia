# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :trivia_id
      t.text :body
      t.text :answer_type
      t.text :correct_value

      t.timestamps
    end
  end
end
