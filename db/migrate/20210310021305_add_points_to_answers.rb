class AddPointsToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :points, :integer
  end
end
