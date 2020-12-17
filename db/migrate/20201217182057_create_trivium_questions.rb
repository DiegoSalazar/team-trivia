class CreateTriviumQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :trivium_questions do |t|
      t.belongs_to :trivium, null: false, foreign_key: true
      t.references :question_template, null: false, foreign_key: true
    end
  end
end
