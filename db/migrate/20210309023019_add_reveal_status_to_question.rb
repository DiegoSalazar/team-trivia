class AddRevealStatusToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :revealed, :integer, default: 0
  end
end
