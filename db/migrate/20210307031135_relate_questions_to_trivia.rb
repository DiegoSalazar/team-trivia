class RelateQuestionsToTrivia < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :trivium_id, :integer
  end
end
