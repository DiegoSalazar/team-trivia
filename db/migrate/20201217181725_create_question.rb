class CreateQuestion < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.text :correct_answer
      t.integer :question_type, default: 0
    end
  end
end
