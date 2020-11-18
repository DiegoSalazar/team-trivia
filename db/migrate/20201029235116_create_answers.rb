# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.integer :submission_id
      t.integer :question_id
      t.integer :user_id
      t.integer :vote_count
      t.text :value

      t.timestamps
    end
  end
end
