class AddScoreFieldsToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :correct_count, :integer, default: 0
    add_column :submissions, :total, :integer, default: 0
  end
end
