class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :trivium_id
      t.integer :team_id
      t.integer :player_id

      t.timestamps
    end
  end
end
