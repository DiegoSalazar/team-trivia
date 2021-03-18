class CreateQuestion < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :player_id
      t.integer :trivium_id
      t.text :body
      t.integer :question_type, default: 0
      t.integer :revealed, default: 0
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
