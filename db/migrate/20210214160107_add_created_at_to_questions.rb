class AddCreatedAtToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :created_at, :datetime
    add_column :questions, :updated_at, :datetime
  end
end
