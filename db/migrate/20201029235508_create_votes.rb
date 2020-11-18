class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.string :voteable_type
      t.integer :voteable_id

      t.timestamps
    end
  end
end
