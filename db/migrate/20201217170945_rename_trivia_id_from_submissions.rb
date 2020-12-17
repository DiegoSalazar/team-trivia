class RenameTriviaIdFromSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :trivium_id, :integer, null: false
    remove_column :submissions, :trivium_id
  end
end
