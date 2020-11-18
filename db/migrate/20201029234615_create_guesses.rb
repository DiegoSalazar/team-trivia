class CreateGuesses < ActiveRecord::Migration[6.0]
  def change
    create_table :guesses do |t|
      t.integer :submission_id
      t.integer :question_id
      t.integer :user_id
      t.text :value

      t.timestamps
    end
  end
end
