class CreateAnswerTemplate < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_templates do |t|
      t.text :body
      t.references :question_template, null: false, foreign_key: true
    end
  end
end
