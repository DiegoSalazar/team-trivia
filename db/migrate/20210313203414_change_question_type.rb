# frozen_string_literal: true

class ChangeQuestionType < ActiveRecord::Migration[6.0]
  def change
    change_column :questions, :question_type, :integer, default: 0
  end
end
