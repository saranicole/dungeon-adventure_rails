class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :race
      t.integer :stats
      t.integer :health
      t.references :game
      t.string :location

      t.timestamps
    end
  end
end
