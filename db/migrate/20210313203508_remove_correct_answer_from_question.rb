# frozen_string_literal: true

class RemoveCorrectAnswerFromQuestion < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :correct_answer
  end
end
