class AddScoreFieldsToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :score, :integer, default: 0
  end
end
