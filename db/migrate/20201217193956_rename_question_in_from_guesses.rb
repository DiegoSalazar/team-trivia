class RenameQuestionInFromGuesses < ActiveRecord::Migration[6.0]
  def change
    add_column :guesses, :question_template_id, :integer, null: false
    remove_column :guesses, :question_id
  end
end
