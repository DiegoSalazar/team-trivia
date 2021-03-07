class CreateQuestion < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.text :correct_answer
      t.text :question_type
    end
  end
end
