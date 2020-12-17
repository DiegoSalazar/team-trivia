class AddMaxQuestionsToTrivia < ActiveRecord::Migration[6.0]
  def change
    add_column :trivia, :max_questions, :integer, null: false, default: 20
  end
end
